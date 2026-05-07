import '../domain/entities/guide_card.dart';
import '../domain/entities/guide_category.dart';
import '../domain/entities/guide_detail.dart';
import '../domain/entities/guide_step.dart';
import '../domain/entities/step_bookmark.dart';
import '../domain/entities/step_enums.dart';

abstract class GuideDummyData {
  GuideDummyData._();

  static const _markdown1 =
      '## Overview\n\n'
      'This step guides you through the essential requirements.\n\n'
      '### Key Points\n\n'
      '- **Requirement 1**: Complete all necessary forms.\n'
      '- **Requirement 2**: Gather supporting documents.\n'
      '- **Requirement 3**: Submit your application.\n\n'
      '> **Important**: Double-check all information before submission.';

  static const _markdown2 =
      '## Instructions\n\n'
      '### Prerequisites\n\n'
      '- All necessary identification documents\n'
      '- Completed prior steps in this guide\n'
      '- Any required fees ready for payment\n\n'
      '### Detailed Steps\n\n'
      '1. Prepare Your Documents\n'
      '2. Visit the Relevant Office\n'
      '3. Submit Your Application\n'
      '4. Receive Acknowledgment';

  static final List<GuideCategory> categories = [
    const GuideCategory(
      id: 'cat-1',
      slug: 'business-registration',
      name: 'Business Registration',
      sortOrder: 1,
      description: 'Everything you need to legally register and start your business.',
      icon: 'document_scanner',
    ),
    const GuideCategory(
      id: 'cat-2',
      slug: 'tax-compliance',
      name: 'Tax & Compliance',
      sortOrder: 2,
      description: 'Understand and manage your tax obligations as a business.',
      icon: 'receipt_long',
    ),
    const GuideCategory(
      id: 'cat-3',
      slug: 'operations-growth',
      name: 'Operations & Growth',
      sortOrder: 3,
      description: 'Scale your operations, hire employees, and grow sustainably.',
      icon: 'trending_up',
    ),
  ];

  static List<GuideDetail> get _guides => [
    const GuideDetail(
      id: 'guide-1',
      slug: 'register-business-ethiopia',
      name: 'Register Your Business in Ethiopia',
      description: 'A complete walkthrough for registering a new business in Ethiopia.',
      progress: GuideProgressSummary(
        totalSteps: 5,
        completedSteps: 0,
        skippedSteps: 0,
        inProgressSteps: 0,
      ),
      steps: [
        GuideStep(
          id: 'step-1-1',
          slug: 'choose-legal-structure',
          title: 'Choose Legal Structure',
          stepType: StepType.informational,
          sortOrder: 1,
          status: StepStatus.inProgress,
          description: 'Learn about the different legal structures and choose the right one for your business.',
          estimatedTime: 10,
          detailedContent: {'markdown': _markdown1},
        ),
        GuideStep(
          id: 'step-1-2',
          slug: 'reserve-company-name',
          title: 'Reserve Company Name',
          stepType: StepType.actionRequired,
          sortOrder: 2,
          status: StepStatus.locked,
          description: 'Reserve a unique company name with the Ministry of Trade.',
          estimatedTime: 30,
          detailedContent: {'markdown': _markdown2},
        ),
        GuideStep(
          id: 'step-1-3',
          slug: 'prepare-documents',
          title: 'Prepare Registration Documents',
          stepType: StepType.documentSubmission,
          sortOrder: 3,
          status: StepStatus.locked,
          description: 'Gather and prepare all required documents for business registration.',
          estimatedTime: 60,
          detailedContent: {'markdown': _markdown1},
        ),
        GuideStep(
          id: 'step-1-4',
          slug: 'submit-registration',
          title: 'Submit Registration Application',
          stepType: StepType.actionRequired,
          sortOrder: 4,
          status: StepStatus.locked,
          description: 'Submit your completed application to the relevant authority.',
          estimatedTime: 45,
          detailedContent: {'markdown': _markdown2},
        ),
        GuideStep(
          id: 'step-1-5',
          slug: 'obtain-license',
          title: 'Obtain Business License',
          stepType: StepType.verification,
          sortOrder: 5,
          status: StepStatus.locked,
          description: 'Complete final verification and receive your business license.',
          estimatedTime: 20,
          detailedContent: {'markdown': _markdown1},
        ),
      ],
    ),
    const GuideDetail(
      id: 'guide-2',
      slug: 'business-tax-obligations',
      name: 'Understanding Business Tax Obligations',
      description: "Navigate Ethiopia's tax system and stay compliant with your obligations.",
      progress: GuideProgressSummary(
        totalSteps: 5,
        completedSteps: 0,
        skippedSteps: 0,
        inProgressSteps: 0,
      ),
      steps: [
        GuideStep(
          id: 'step-2-1',
          slug: 'tax-types-overview',
          title: 'Ethiopian Tax Types Overview',
          stepType: StepType.informational,
          sortOrder: 1,
          status: StepStatus.inProgress,
          description: 'Understand the different types of taxes applicable to businesses in Ethiopia.',
          estimatedTime: 15,
          detailedContent: {'markdown': _markdown2},
        ),
        GuideStep(
          id: 'step-2-2',
          slug: 'register-for-tin',
          title: 'Register for TIN',
          stepType: StepType.actionRequired,
          sortOrder: 2,
          status: StepStatus.locked,
          description: 'Register for a Taxpayer Identification Number with the revenue authority.',
          estimatedTime: 30,
          detailedContent: {'markdown': _markdown1},
        ),
        GuideStep(
          id: 'step-2-3',
          slug: 'file-monthly-vat',
          title: 'File Monthly VAT Returns',
          stepType: StepType.actionRequired,
          sortOrder: 3,
          status: StepStatus.locked,
          description: 'Learn how to calculate and file your monthly VAT returns.',
          estimatedTime: 20,
          isOptional: true,
          detailedContent: {'markdown': _markdown2},
        ),
        GuideStep(
          id: 'step-2-4',
          slug: 'prepare-annual-return',
          title: 'Prepare Annual Tax Return',
          stepType: StepType.documentSubmission,
          sortOrder: 4,
          status: StepStatus.locked,
          description: 'Prepare and submit your annual corporate income tax return.',
          estimatedTime: 90,
          detailedContent: {'markdown': _markdown1},
        ),
        GuideStep(
          id: 'step-2-5',
          slug: 'tax-clearance',
          title: 'Get Tax Clearance Certificate',
          stepType: StepType.verification,
          sortOrder: 5,
          status: StepStatus.locked,
          description: 'Obtain your tax clearance certificate after fulfilling all obligations.',
          estimatedTime: 40,
          detailedContent: {'markdown': _markdown2},
        ),
      ],
    ),
    const GuideDetail(
      id: 'guide-3',
      slug: 'hiring-first-employees',
      name: 'Hiring Your First Employees',
      description: 'Everything you need to know about hiring, contracts, and employer obligations.',
      progress: GuideProgressSummary(
        totalSteps: 5,
        completedSteps: 0,
        skippedSteps: 0,
        inProgressSteps: 0,
      ),
      steps: [
        GuideStep(
          id: 'step-3-1',
          slug: 'employment-law-basics',
          title: 'Ethiopian Employment Law Basics',
          stepType: StepType.informational,
          sortOrder: 1,
          status: StepStatus.inProgress,
          description: 'Understand the legal framework for employment in Ethiopia.',
          estimatedTime: 20,
          detailedContent: {'markdown': _markdown1},
        ),
        GuideStep(
          id: 'step-3-2',
          slug: 'draft-employment-contract',
          title: 'Draft Employment Contract',
          stepType: StepType.actionRequired,
          sortOrder: 2,
          status: StepStatus.locked,
          description: 'Create a legally compliant employment contract for your new hires.',
          estimatedTime: 45,
          detailedContent: {'markdown': _markdown2},
        ),
        GuideStep(
          id: 'step-3-3',
          slug: 'register-with-pension',
          title: 'Register with Pension Authority',
          stepType: StepType.documentSubmission,
          sortOrder: 3,
          status: StepStatus.locked,
          description: 'Register your employees with the pension and social security authority.',
          estimatedTime: 30,
          detailedContent: {'markdown': _markdown1},
        ),
        GuideStep(
          id: 'step-3-4',
          slug: 'setup-payroll',
          title: 'Set Up Payroll System',
          stepType: StepType.actionRequired,
          sortOrder: 4,
          status: StepStatus.locked,
          description: 'Implement a payroll system for salary, tax, and pension deductions.',
          estimatedTime: 60,
          detailedContent: {'markdown': _markdown2},
        ),
        GuideStep(
          id: 'step-3-5',
          slug: 'workplace-safety',
          title: 'Workplace Safety Registration',
          stepType: StepType.verification,
          sortOrder: 5,
          status: StepStatus.locked,
          description: 'Complete workplace safety registration and compliance checks.',
          estimatedTime: 25,
          isOptional: true,
          detailedContent: {'markdown': _markdown1},
        ),
      ],
    ),
  ];

  static List<GuideCategory> getCategoryTree() {
    final result = <GuideCategory>[];
    for (final cat in categories) {
      final catGuides = <GuideCard>[];
      final catIdx = int.tryParse(cat.id.split('-').last) ?? 0;
      for (final guide in _guides) {
        final guideIdx = int.tryParse(guide.id.split('-').last) ?? 0;
        if (catIdx == guideIdx) {
          catGuides.add(
            GuideCard(
              id: guide.id,
              slug: guide.slug,
              name: guide.name,
              categoryId: cat.id,
              description: guide.description,
            ),
          );
          break;
        }
      }
      result.add(
        GuideCategory(
          id: cat.id,
          slug: cat.slug,
          name: cat.name,
          sortOrder: cat.sortOrder,
          description: cat.description,
          icon: cat.icon,
          guides: catGuides,
        ),
      );
    }
    return result;
  }

  static List<GuideCard> getAllGuideCards() {
    return _guides
        .map(
          (g) => GuideCard(
            id: g.id,
            slug: g.slug,
            name: g.name,
            categoryId: 'cat-${int.tryParse(g.id.split('-').last) ?? 1}',
            description: g.description,
          ),
        )
        .toList();
  }

  static GuideDetail? getGuideDetail(String slug) {
    final idx = _guides.indexWhere((g) => g.slug == slug);
    return idx == -1 ? null : _guides[idx];
  }

  static GuideStep? getStep(String guideSlug, String stepSlug) {
    final guide = getGuideDetail(guideSlug);
    if (guide == null) return null;
    final idx = guide.steps.indexWhere((s) => s.slug == stepSlug);
    return idx == -1 ? null : guide.steps[idx];
  }

  static List<GuideCard> searchGuides(String query) {
    if (query.isEmpty) return getAllGuideCards();
    final lower = query.toLowerCase();
    return getAllGuideCards().where((g) {
      return g.name.toLowerCase().contains(lower) || (g.description?.toLowerCase().contains(lower) ?? false);
    }).toList();
  }

  static const List<GuideCard> recentGuides = [
    GuideCard(
      id: 'guide-2',
      slug: 'business-tax-obligations',
      name: 'Understanding Business Tax Obligations',
      categoryId: 'cat-2',
      description: "Navigate Ethiopia's tax system and stay compliant with your obligations.",
      icon: 'receipt_long',
    ),
    GuideCard(
      id: 'guide-3',
      slug: 'hiring-first-employees',
      name: 'Hiring Your First Employees',
      categoryId: 'cat-3',
      description: 'Everything you need to know about hiring, contracts, and employer obligations.',
      icon: 'trending_up',
    ),
  ];

  static const List<StepBookmark> bookmarks = [
    StepBookmark(
      id: 'bkmk-1',
      stepId: 'step-2-3',
      stepTitle: 'File Monthly VAT Returns',
      guideName: 'Understanding Business Tax Obligations',
      createdAt: '2026-05-06T10:30:00Z',
    ),
    StepBookmark(
      id: 'bkmk-2',
      stepId: 'step-1-2',
      stepTitle: 'Reserve Company Name',
      guideName: 'Register Your Business in Ethiopia',
      createdAt: '2026-05-05T14:15:00Z',
    ),
  ];
}
