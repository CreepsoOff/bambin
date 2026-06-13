//
//  StatisticsView.swift
//  bambin
//
//  Created by Imane on 09/06/2026.
//

import SwiftUI

struct StatisticsView: View {

    // Données entrantes
    // View = dépend de données externes, pas de logique métier interne
    var user: User
    var activities: [Activity]
    var userLogs: [UserLog]

    // Je stocke la période sélectionnée par l’utilisateur dans l’UI
    // @State permet à SwiftUI de RE-RENDER la vue automatiquement dès que l’utilisateur change de filtre (day, week, month, year)
    // C’est une variable LOCALE à la View (pas partagée ailleurs)
    @State private var selectedTimePeriod: UserLog.TimePeriod = .day

    // MARK: - 1  FILTRE UTILISATEUR

    // Je filtre uniquement les logs qui appartiennent à l’utilisateur actuel
    // Objectif : éviter de mélanger les données de plusieurs utilisateurs
    // Je compare userID du log avec l’id du user connecté
    // Résultat : dataset propre et personnalisé

    var filteredUserLogs: [UserLog] {

        userLogs.filter {
            $0.userID == user.id
        }
    }

    // MARK: - 2  FILTRE TEMPOREL

    // J'applique un deuxième filtre sur les logs déjà filtrés par user
    // Ici je réduit les données selon la période sélectionnée (jour, semaine, mois, année)
    var filteredLogs: [UserLog] {

        // Je récupère le calendrier système de l’utilisateur
        // Calendar.current : Permet de gérer correctement les dates selon la région (FR, US, etc.)
        let calendar = Calendar.current

        // Je capture la date actuelle au moment du calcul
        // Sert de point de comparaison pour filtrer les logs
        let now = Date()

        // Je filtre la collection 'userLogsFilter' pour ne garder que les logs correspondants à la période selectionner.
        return filteredUserLogs.filter { log in

            // J'analyse la période temporelle sélectionnée par l'utilisateur via un switch.
            switch selectedTimePeriod {

            case .day:
                // Vérifie si la date du log et 'now' tombent le même jour, le même mois et la même année.
                // isDate(_:inSameDayAs:) : compare deux dates en ignorant leur composante temporelle (heures, minutes, secondes, millisecondes) pour se concentrer exclusivement sur leur identité calendaire.
                return calendar.isDate(log.date, inSameDayAs: now)

            case .week:
                // Compare si les deux dates appartiennent à la même semaine de l'année.
                // La granularité '.weekOfYear' ignore les jours de la semaine, les heures, etc.
                return calendar.isDate(
                    log.date,
                    equalTo: now,
                    toGranularity: .weekOfYear
                )

            case .month:
                // Compare si les deux dates sont dans le même mois (indépendamment du jour ou de l'heure).
                return calendar.isDate(
                    log.date,
                    equalTo: now,
                    toGranularity: .month
                )

            case .year:
                // Vérifie uniquement si l'année est identique entre le log et 'now'.
                return calendar.isDate(
                    log.date,
                    equalTo: now,
                    toGranularity: .year
                )
            }
        }
    }

    //   MARK: - Transformation des données

    // --> CALCUL DU TEMPS TOTAL SANS ÉCRANS

    var totaleDuration: Int {
        // Je pars de 0, puis j’ajoute la durée de chaque log filtré pour obtenir la durée totale.
        // .reduce : calcule toutes les valeurs du tableau
        // (0) : valeur initial --> à partir de 0
        filteredLogs.reduce(0) { total, log in
            total + log.duration
        }
    }

    // --> FORMATAGE DURÉE TOTALE

    // Je transforme un nombre brut (minutes) en affichage lisible UX
    var formattedTotalDuration: String {

        // Conversion des minutes en heures entières
        let hours = totaleDuration / 60
        // On récupère le reste des minutes après conversion en heures
        let minutes = totaleDuration % 60

        // - d’1 heure -> affichage en minutes uniquement
        if hours == 0 {
            return "\(minutes)min"
        } else {
            // + d'1 heure -> affichage en heure et minute
            // %02d force 2 chiffres (ex: 05 au lieu de 5)
            return "\(hours)h\(String(format: "%02d", minutes))"
        }
    }

    // Fonction utilitaire pour éviter duplication de code
    // Convertit minutes → format lisible

    func formatMinutes(_ total: Int) -> String {
        // convertion minute -> heure
        let hours = total / 60
        // récupère le reste (en minutes)
        let minutes = total % 60

        if hours == 0 {
            // -1h -> affichage minute
            return "\(minutes)min"
        } else {
            // + 1h --> affichage en heure et minute
            // format : 05 au lieu de 5
            return "\(hours)h\(String(format: "%02d", minutes))"
        }
    }

    // --> CALCUL TOTAL ACTIVITÉS

    // Chaque log représente une activité réalisée
    // je compte le nombre d’entrées (.count)
    var totaleActivities: Int {
        filteredLogs.count
    }

    //   MARK: - Groupement de données

    // --> MOYENNE / JOUR D'ACTIVITÉS RÉALISÉES

    // combien de minutes par jour en moyenne ?
    var averagePerDayMinutes: Int {

        // days : propriété calculée
        // Set : collection sans doublons
        // .map : récupére chaque userLog, applique une transformation et retourne un nouveau tableau
        let days = Set(
            filteredLogs.map {

                // Calendar : calendrier système de l'utilisateur (fuseaux horaire, réglages régionaux)
                // startOfDay(for:) : transforme une date complète en “début de journée”
                // 2026-06-13 14:32:10 --> 2026-06-13 00:00:00
                Calendar.current.startOfDay(for: $0.date)
            }
        ).count  // je compte le nombre d'éléments unique

        // guard : si la condition n’est PAS respectée --> on sort immédiatement pour éviter le crash
        // days > 0 : vérifie qu’il existe au moins 1 jour valide
        // sinon return 0 pour le calcul de division
        guard days > 0 else { return 0 }

        // je retourne la valeur du temps total sans écrans / nombre de jours
        return totaleDuration / days
    }

    //  -->  ACTIVITÉS EN HAUSSE

    // comparaison entre :
    // période actuelle (filteredLogs)
    // et
    // la période précédente (previousLogs)
    // résultat = actuelle - précédente
    var activitiesIncrease: Int {

        // régle de date de l'utilisateur
        let calendar = Calendar.current
        // instant actuel
        let now = Date()

        // préparation des logs de la periode précédente
        let previousLogs: [UserLog]

        // adapte le calcul en fonction de la saisie utilisateur
        switch selectedTimePeriod {

        case .day:

            // guard : sécurité (si nil, on sort)
            // calendar.date : demande au systeme de calculer une nouvelle date
            // byAdding: ajouter ou retirer une unité de temps à une date
            // valeur : -1 (retirer 1)
            // to : point de départ --> date actuel
            guard
                let yesterday = calendar.date(
                    byAdding: .day,
                    value: -1,
                    to: now
                )
            else {
                return 0
            }

            // je prends tous les logs de l’utilisateur et je garde seulement ceux d’hier
            // inSameDayAs: compare le jour seulement
            previousLogs = filteredUserLogs.filter {
                calendar.isDate($0.date, inSameDayAs: yesterday)
            }

        case .week:
            // idem que DAY
            guard
                let lastWeek = calendar.date(
                    byAdding: .weekOfYear,
                    value: -1,
                    to: now
                )
            else {
                return 0
            }

            previousLogs = filteredUserLogs.filter {
                calendar.isDate(
                    $0.date,
                    equalTo: lastWeek,
                    toGranularity: .weekOfYear
                )
            }

        case .month:
            // idem que DAY
            guard
                let lastMonth = calendar.date(
                    byAdding: .month,
                    value: -1,
                    to: now
                )
            else {
                return 0
            }

            previousLogs = filteredUserLogs.filter {
                calendar.isDate(
                    $0.date,
                    equalTo: lastMonth,
                    toGranularity: .month
                )
            }

        case .year:
            // idem que DAY
            guard
                let lastYear = calendar.date(
                    byAdding: .year,
                    value: -1,
                    to: now
                )
            else {
                return 0
            }

            previousLogs = filteredUserLogs.filter {
                calendar.isDate(
                    $0.date,
                    equalTo: lastYear,
                    toGranularity: .year
                )
            }
        }

        // calcule la différence entre le nombre de logs de la période actuelle et la période précédente
        return filteredLogs.count - previousLogs.count
    }

    
    // --> ACTIVITÉS EN HAUSSE FORMATÉE

    // afficher la valeur de activité en hausse en chaîne de caractères
    var formattedActivitiesIncrease: String {

        if activitiesIncrease > 0 {
            return "+\(activitiesIncrease)"
        }

        return "\(activitiesIncrease)"
    }

    
    // --> TOP 3 ACTIVITÉS

    // retourne un tableau de type tuples ([objet, nbr de fois jouer])
    var topActivities: [(activity: Activity, count: Int)] {

        // je regroupe par activités
        // Dictionnary :
        // Avant (liste plate) :
        // [A, A, B, A, C, B]
        // Aprés (groupé) :
        // A --> [A, A, A]
        // B --> [B, B]
        // C --> [C]
        let grouped = Dictionary(grouping: filteredLogs, by: { $0.activityID })

        // result de type tuples [(object, count)]
        // .compactMap : transforme chaque éléments mais supprime les nil
        let result: [(activity: Activity, count: Int)] = grouped.compactMap {
            key,
            logs in
            // sort du bloc de code si nil
            guard let activity =
                    // contient la première activité dont l'élément id de l'activité correspond à l'activité
                    activities.first(where: { $0.id == key })
            else {
                // si aucune activités alors nil
                return nil
            }
            // return un tableau contenant l'activité et le nombre de fois dont l'activité est affiché
            return (activity: activity, count: logs.count)
        }

        // return le résultat
        return
            result
            // trie les éléments par nombre d’occurrences (count)
            // ordre décroissant : du plus fréquent au moins fréquent
            .sorted { $0.count > $1.count }
            // garde uniquement les 3 premiers éléments (TOP 3)
            .prefix(3)
            .map { $0 }
    }

    
    // Fonction utilitaire pour éviter duplication de code
    // associe une image différente selon la position
    
    func topImage(for index: Int) -> String {
        switch index {
        case 0: return "reward1"
        case 1: return "reward2"
        case 2: return "reward3"
        default: return "reward1"
        }
    }

    // MARK: - UI

    var body: some View {

        VStack {

            ScrollView {

                // PROFIL
                HStack {
                    
                    // composant user
                    UserAvatar(user: user)

                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            Text("Hello")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            
                            Image(systemName: "hand.wave.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.yellow)
                        }
                        

                        // nom utilisateur
                        Text(user.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 2)
                    }

                    Spacer()
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.08), radius: 10, y: 4)

                
                
                // Picker segmenté (day, week, month, year)
                Picker("", selection: $selectedTimePeriod) {
                    ForEach(UserLog.TimePeriod.allCases, id: \.self) { time in
                        Text(time.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)

                
                // CARTES STATISTIQUES

                HStack(spacing: 15) {

                    // Composant cardStatistics
                    // je passe a valeur de la durée total formatée
                    CardStatistics(
                        title: "Heure sans écrans",
                        text: formattedTotalDuration,
                        backgroundColor: .green
                    )

                    // Composant cardStatistics
                    // je passe le calcul total des activités
                    CardStatistics(
                        title: "Activités réalisées",
                        text: "\(totaleActivities)",
                        backgroundColor: .red
                    )
                }
                .padding(.bottom, 10)

                HStack(spacing: 15) {

                    // Composant cardStatistics
                    // je passe la valeur la durée moyenne formaté
                    CardStatistics(
                        title: "Moyenne par jour",
                        text: formatMinutes(averagePerDayMinutes),
                        backgroundColor: .yellow
                    )

                    
                    // Composant cardStatistics
                    // je passe la valeur de activité en hausse
                    CardStatistics(
                        title: "Activités en hausse",
                        text: formattedActivitiesIncrease,
                        backgroundColor: .cyan
                    )
                }

                // TOP 3 ACTIVITÉS

                VStack(spacing: 20) {

                    HStack {
                        Text("Top 3 des activités les plus jouées")
                            .font(.system(size: 24, weight: .semibold))
                    }.padding(.top, 10)

                    ForEach(
                        // enumerated() : ajoute la position (index) à chaque élément
                        // Avant  : [(Dessin, 12), (Cuisine, 8), (Nature, 5)]
                        // Après  : [(0, Dessin), (1, Cuisine), (2, Nature)]

                        // Array() : convertit le résultat de enumerated() en tableau

                        // Chaque élément généré par enumerated() contient :
                            // - offset  : index (0, 1, 2...)
                            // - element : élément original du tableau
                            // On utilise l'id de l'activité comme identifiant unique pour SwiftUI
                        // Imagé :
                        // element
                        //  └─ activity
                        //        └─ id
                        Array(topActivities.enumerated()),
                        id: \.element.activity.id
                    ) { index, item in
                        
                        // Création d'une carte pour chaque activité du classement
                        CardTopActivities(
                            // Objet Activity à afficher
                            activity: item.activity,
                            // Nombre de fois où l'activité a été réalisée
                            count: item.count,
                            // Image de récompense selon le rang :
                                    // index 0 --> reward1
                                    // index 1 --> reward2
                                    // index 2 --> reward3
                            topImage: topImage(for: index)
                        )

                    }
                }

                Spacer()
            }.scrollIndicators(.hidden)
                .padding()

        }.background {
            ZStack {
                Color.lavender
                Image("backgroundPattern")
                    .resizable(resizingMode: .tile)
                    .blendMode(.multiply)
                    .opacity(0.4)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {

    // Prévisualisation de la vue avec des données fictives (MockData)
    StatisticsView(
        // Utilisateur situé à l'index 0 du tableau familyUsers dans la structure MockData
        user: MockData.familyUsers[0],
        // Liste des activités dans la structure MockData
        activities: MockData.activities,
        // Les Historique des activités dans la structure MockData
        userLogs: MockData.userLogs
    )
}
