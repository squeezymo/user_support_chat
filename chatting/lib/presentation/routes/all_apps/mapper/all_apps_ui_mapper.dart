import '../../../../commons/cacheable.dart';
import '../../../../domain/model/models.dart';
import '../models/models.dart';

class AllAppsUiMapper {
  static List<SupportedApplicationUi> mapApplications(
    Cacheable<List<SupportedApplication>> applications,
  ) {
    return applications.data
        .map(
          (application) => SupportedApplicationUi(
            id: application.id,
            name: application.name,
          ),
        )
        .toList(growable: false);
  }
}
