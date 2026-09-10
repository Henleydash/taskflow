// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'TaskFlow';

  @override
  String get myTasks => 'Mes tâches';

  @override
  String get addTask => 'Ajouter une tâche';

  @override
  String get editTask => 'Modifier la tâche';

  @override
  String get taskDetails => 'Détails de la tâche';

  @override
  String get settings => 'Paramètres';

  @override
  String get statistics => 'Statistiques';

  @override
  String get titleLabel => 'Titre';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get dueDateLabel => 'Échéance';

  @override
  String get categoryLabel => 'Catégorie';

  @override
  String get priorityLabel => 'Priorité';

  @override
  String get priorityLow => 'Basse';

  @override
  String get priorityMedium => 'Moyenne';

  @override
  String get priorityHigh => 'Haute';

  @override
  String get categoryWork => 'Travail';

  @override
  String get categoryPersonal => 'Personnel';

  @override
  String get categoryHealth => 'Santé';

  @override
  String get categoryStudy => 'Études';

  @override
  String get categoryOther => 'Autre';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get cancel => 'Annuler';

  @override
  String get noTasksYet => 'Aucune tâche pour le moment';

  @override
  String get noTasksHint => 'Appuyez sur + pour ajouter votre première tâche';

  @override
  String get markComplete => 'Marquer comme terminée';

  @override
  String get markIncomplete => 'Marquer comme non terminée';

  @override
  String get filterAll => 'Toutes';

  @override
  String get language => 'Langue';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get completedTasks => 'Terminées';

  @override
  String get pendingTasks => 'En cours';

  @override
  String get totalTasks => 'Total';

  @override
  String get titleRequired => 'Le titre est requis';

  @override
  String get deleteConfirmTitle => 'Supprimer la tâche ?';

  @override
  String get deleteConfirmBody => 'Cette action est irréversible.';

  @override
  String get taskAdded => 'Tâche ajoutée';

  @override
  String get taskUpdated => 'Tâche mise à jour';

  @override
  String get taskDeleted => 'Tâche supprimée';
}
