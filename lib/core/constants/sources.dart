/// Every source behind ZebraPace's health information (App Store guideline
/// 1.4.1: medical information needs citations the user can easily find).
///
/// Metadata comes from Crossref, looked up by DOI on 2026-11-20 (the NICE
/// guideline is a web page, not a DOI). When adding a claim to the app, add
/// its source here and list it under the matching [SourceTopic]; never cite
/// from memory.
library;

class Source {
  const Source({
    required this.authors,
    required this.year,
    required this.title,
    required this.venue,
    required this.url,
  });

  final String authors;
  final int year;
  final String title;
  final String venue;
  final String url;

  /// Short form for inline use, e.g. "Freeman R et al., 2011".
  String get short => '$authors, $year';
}

/// Where in the app a group of sources is relevant. Each has a localized
/// title (sourceTopicTitle in sources_screen.dart).
enum SourceTopic { pacing, pem, standTest, heartSignals, sweating, mets, exercise, fearExposure, sleep }

const Map<String, Source> kSources = {
  'jason2008': Source(
    authors: 'Jason L',
    year: 2008,
    title: 'The Energy Envelope Theory and Myalgic Encephalomyelitis/Chronic Fatigue Syndrome',
    venue: 'AAOHN Journal',
    url: 'https://doi.org/10.1177/216507990805600502',
  ),
  'nice2021': Source(
    authors: 'National Institute for Health and Care Excellence (NICE)',
    year: 2021,
    title:
        'Myalgic encephalomyelitis (or encephalopathy)/chronic fatigue syndrome: diagnosis and management (NG206)',
    venue: 'NICE guideline',
    url: 'https://www.nice.org.uk/guidance/ng206',
  ),
  'iom2015': Source(
    authors: 'Institute of Medicine',
    year: 2015,
    title: 'Beyond Myalgic Encephalomyelitis/Chronic Fatigue Syndrome: Redefining an Illness',
    venue: 'National Academies Press',
    url: 'https://doi.org/10.17226/19012',
  ),
  'chu2018': Source(
    authors: 'Chu L et al.',
    year: 2018,
    title:
        'Deconstructing post-exertional malaise in myalgic encephalomyelitis/chronic fatigue syndrome: A patient-centered, cross-sectional survey',
    venue: 'PLOS ONE',
    url: 'https://doi.org/10.1371/journal.pone.0197811',
  ),
  'cheung2003': Source(
    authors: 'Cheung K et al.',
    year: 2003,
    title: 'Delayed Onset Muscle Soreness',
    venue: 'Sports Medicine',
    url: 'https://doi.org/10.2165/00007256-200333020-00005',
  ),
  'ostuni2024': Source(
    authors: 'Ostuni NF et al.',
    year: 2024,
    title: 'The Effect of Joint Hypermobility Syndrome on DOMS and Recovery Time',
    venue: 'International Journal of Sports Physical Therapy',
    url: 'https://doi.org/10.26603/001c.91644',
  ),
  'hody2019': Source(
    authors: 'Hody S et al.',
    year: 2019,
    title: 'Eccentric Muscle Contractions: Risks and Benefits',
    venue: 'Frontiers in Physiology',
    url: 'https://doi.org/10.3389/fphys.2019.00536',
  ),
  'nosaka2026': Source(
    authors: 'Nosaka K',
    year: 2026,
    title: 'Eccentric exercise: Muscle damage to the new normal',
    venue: 'Journal of Sport and Health Science',
    url: 'https://doi.org/10.1016/j.jshs.2026.101126',
  ),
  'freeman2011': Source(
    authors: 'Freeman R et al.',
    year: 2011,
    title:
        'Consensus statement on the definition of orthostatic hypotension, neurally mediated syncope and the postural tachycardia syndrome',
    venue: 'Clinical Autonomic Research',
    url: 'https://doi.org/10.1007/s10286-011-0119-5',
  ),
  'sheldon2015': Source(
    authors: 'Sheldon RS et al.',
    year: 2015,
    title:
        '2015 Heart Rhythm Society Expert Consensus Statement on the Diagnosis and Treatment of Postural Tachycardia Syndrome, Inappropriate Sinus Tachycardia, and Vasovagal Syncope',
    venue: 'Heart Rhythm',
    url: 'https://doi.org/10.1016/j.hrthm.2015.03.029',
  ),
  'taskForce1996': Source(
    authors:
        'Task Force of the European Society of Cardiology and the North American Society of Pacing and Electrophysiology',
    year: 1996,
    title: 'Heart rate variability: standards of measurement, physiological interpretation and clinical use',
    venue: 'Circulation',
    url: 'https://doi.org/10.1161/01.cir.93.5.1043',
  ),
  'martinmaki2006': Source(
    authors: 'Martinmäki K et al.',
    year: 2006,
    title: 'Intraindividual validation of heart rate variability indexes to measure vagal effects on hearts',
    venue: 'American Journal of Physiology-Heart and Circulatory Physiology',
    url: 'https://doi.org/10.1152/ajpheart.00054.2005',
  ),
  'goldberger2006': Source(
    authors: 'Goldberger JJ et al.',
    year: 2006,
    title: 'Assessment of parasympathetic reactivation after exercise',
    venue: 'American Journal of Physiology-Heart and Circulatory Physiology',
    url: 'https://doi.org/10.1152/ajpheart.01118.2005',
  ),
  'plews2013': Source(
    authors: 'Plews DJ et al.',
    year: 2013,
    title:
        'Training Adaptation and Heart Rate Variability in Elite Endurance Athletes: Opening the Door to Effective Monitoring',
    venue: 'Sports Medicine',
    url: 'https://doi.org/10.1007/s40279-013-0071-8',
  ),
  'pecchia2018': Source(
    authors: 'Pecchia L et al.',
    year: 2018,
    title:
        'Are ultra-short heart rate variability features good surrogates of short-term ones? State-of-the-art review and recommendations',
    venue: 'Healthcare Technology Letters',
    url: 'https://doi.org/10.1049/htl.2017.0090',
  ),
  'zhang2020': Source(
    authors: 'Zhang Y et al.',
    year: 2020,
    title:
        'Validity of Wrist-Worn photoplethysmography devices to measure heart rate: A systematic review and meta-analysis',
    venue: 'Journal of Sports Sciences',
    url: 'https://doi.org/10.1080/02640414.2020.1767348',
  ),
  'gronwald2024': Source(
    authors: 'Gronwald T et al.',
    year: 2024,
    title: 'Orthostatic testing for heart rate and heart rate variability monitoring in exercise science and practice',
    venue: 'European Journal of Applied Physiology',
    url: 'https://doi.org/10.1007/s00421-024-05601-4',
  ),
  'cole1999': Source(
    authors: 'Cole CR et al.',
    year: 1999,
    title: 'Heart-Rate Recovery Immediately after Exercise as a Predictor of Mortality',
    venue: 'New England Journal of Medicine',
    url: 'https://doi.org/10.1056/nejm199910283411804',
  ),
  'sletten2012': Source(
    authors: 'Sletten DM et al.',
    year: 2012,
    title: 'COMPASS 31: A Refined and Abbreviated Composite Autonomic Symptom Score',
    venue: 'Mayo Clinic Proceedings',
    url: 'https://doi.org/10.1016/j.mayocp.2012.10.013',
  ),
  'ainsworth2011': Source(
    authors: 'Ainsworth BE et al.',
    year: 2011,
    title: '2011 Compendium of Physical Activities: a second update of codes and MET values',
    venue: 'Medicine & Science in Sports & Exercise',
    url: 'https://doi.org/10.1249/mss.0b013e31821ece12',
  ),
  'herrmann2024': Source(
    authors: 'Herrmann SD et al.',
    year: 2024,
    title: 'The 2024 Compendium of Physical Activities and its expansion',
    venue: 'Journal of Sport and Health Science',
    url: 'https://doi.org/10.1016/j.jshs.2023.09.008',
  ),
  'buryk2022': Source(
    authors: 'Buryk-Iggers S et al.',
    year: 2022,
    title: 'Exercise and Rehabilitation in People With Ehlers-Danlos Syndrome: A Systematic Review',
    venue: 'Archives of Rehabilitation Research and Clinical Translation',
    url: 'https://doi.org/10.1016/j.arrct.2022.100189',
  ),
  'stasiak2025': Source(
    authors: 'Stasiak M et al.',
    year: 2025,
    title: 'Rehabilitation and Physical Activity in Ehlers-Danlos Syndrome: A Review of Interventions and Outcomes',
    venue: 'Quality in Sport',
    url: 'https://doi.org/10.12775/qs.2025.41.60105',
  ),
  'thomee1997': Source(
    authors: 'Thomeé R',
    year: 1997,
    title: 'A Comprehensive Treatment Approach for Patellofemoral Pain Syndrome in Young Women',
    venue: 'Physical Therapy',
    url: 'https://doi.org/10.1093/ptj/77.12.1690',
  ),
  'silbernagel2007': Source(
    authors: 'Silbernagel KG et al.',
    year: 2007,
    title:
        'Continued Sports Activity, Using a Pain-Monitoring Model, during Rehabilitation in Patients with Achilles Tendinopathy',
    venue: 'The American Journal of Sports Medicine',
    url: 'https://doi.org/10.1177/0363546506298279',
  ),
  'ahmed2018': Source(
    authors: 'Ahmed S et al.',
    year: 2018,
    title: 'Effect of aerobic exercise in the treatment of myofascial pain: a systematic review',
    venue: 'Journal of Exercise Rehabilitation',
    url: 'https://doi.org/10.12965/jer.1836406.205',
  ),
  'wang2025': Source(
    authors: 'Wang TJ et al.',
    year: 2025,
    title:
        'Fascial Pathophysiology in Hypermobility Spectrum Disorders and Hypermobile Ehlers–Danlos Syndrome: A Review of Emerging Evidence',
    venue: 'International Journal of Molecular Sciences',
    url: 'https://doi.org/10.3390/ijms26125587',
  ),
  'vlaeyen2000': Source(
    authors: 'Vlaeyen JWS, Linton SJ',
    year: 2000,
    title: 'Fear-avoidance and its consequences in chronic musculoskeletal pain: a state of the art',
    venue: 'Pain',
    url: 'https://doi.org/10.1016/s0304-3959(99)00242-0',
  ),
  'watson2015': Source(
    authors: 'Watson NF et al.',
    year: 2015,
    title:
        'Recommended Amount of Sleep for a Healthy Adult: A Joint Consensus Statement of the American Academy of Sleep Medicine and Sleep Research Society',
    venue: 'SLEEP',
    url: 'https://doi.org/10.5665/sleep.4716',
  ),
};

/// Which sources back each part of the app. Order = shown order.
const Map<SourceTopic, List<String>> kSourcesByTopic = {
  // Step envelope, rest/flare days, the caution message's rest and fluids.
  SourceTopic.pacing: ['jason2008', 'nice2021', 'sheldon2015'],
  // Soreness check, PEM wording, the 72-hour recovery window.
  SourceTopic.pem: ['iom2015', 'chu2018', 'cheung2003', 'ostuni2024', 'hody2019'],
  // Stand test and its POTS / orthostatic hypotension hints.
  SourceTopic.standTest: ['freeman2011', 'sheldon2015'],
  // Resting heart rate and HRV next to the person's own usual.
  SourceTopic.heartSignals: [
    'taskForce1996',
    'martinmaki2006',
    'goldberger2006',
    'plews2013',
    'pecchia2018',
    'zhang2020',
    'gronwald2024',
    'cole1999',
  ],
  SourceTopic.sweating: ['sletten2012'],
  // METs estimates from workouts.
  SourceTopic.mets: ['ainsworth2011', 'herrmann2024'],
  // Stop signals, plan progression, exercise principles for EDS.
  SourceTopic.exercise: [
    'buryk2022',
    'stasiak2025',
    'thomee1997',
    'silbernagel2007',
    'hody2019',
    'nosaka2026',
    'ahmed2018',
    'wang2025',
  ],
  SourceTopic.fearExposure: ['vlaeyen2000'],
  SourceTopic.sleep: ['watson2015'],
};
