import 'package:flutter/material.dart';

import 'package:myportfilo/domain/models/project_model.dart';
import 'package:myportfilo/presentation/case_study/movement_case_study_page.dart';

import 'case_study_page_route.dart';

/// Central switch for project → case study. Add branches (e.g. Click) here later.
void openProjectCaseStudy(BuildContext context, ProjectModel project) {
  switch (project.id) {
    case 'movement':
      Navigator.of(context).push<void>(
        CaseStudyPageRoute<void>(
          pageBuilder: (_) => const MovementCaseStudyPage(),
        ),
      );
      break;
    default:
      break;
  }
}
