-- Additional Study Guides for StudySwap
-- Run this in Supabase SQL Editor AFTER seed_uk_curriculum.sql

CREATE OR REPLACE FUNCTION seed_more_guides()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  seed_user_id uuid;
BEGIN
  IF EXISTS (SELECT 1 FROM study_guides WHERE title = 'GCSE Maths Revision Guide - Algebra' LIMIT 1) THEN
    RAISE NOTICE 'Additional guides already exist, skipping.';
    RETURN;
  END IF;

  SELECT id INTO seed_user_id FROM auth.users LIMIT 1;
  IF seed_user_id IS NULL THEN
    RAISE NOTICE 'No users found. Please create an account first.';
    RETURN;
  END IF;

  INSERT INTO study_guides (user_id, title, subject, year_group, content, upvotes, downvotes) VALUES
  (seed_user_id, 'GCSE Maths Revision Guide - Algebra', 'Mathematics', 10,
   E'# GCSE Maths Revision - Algebra\n\n## Solving Linear Equations\n- Do the same to both sides\n- Move terms with x to one side, numbers to the other\n- Example: 2x + 5 = 13 -> 2x = 8 -> x = 4\n\n## Expanding Brackets\n- Multiply each term inside by the term outside\n- (x + 3)(x + 2) = x^2 + 2x + 3x + 6 = x^2 + 5x + 6\n\n## Factorising\n- Find two numbers that multiply to c and add to b\n- x^2 + 7x + 10 = (x + 2)(x + 5)\n\n## Quadratic Formula\n- x = (-b +/- sqrt(b^2 - 4ac)) / 2a\n- Use when factorising does not work\n\n## Inequalities\n- Solve like equations, but FLIP the sign when multiplying/dividing by a negative\n- 3x - 2 < 7 -> 3x < 9 -> x < 3', 45, 2),

  (seed_user_id, 'GCSE Biology Revision Guide - Topic 1', 'Biology', 10,
   E'# GCSE Biology Revision - Cell Biology\n\n## Cell Structure\n- Nucleus: contains DNA, controls activities\n- Cytoplasm: where chemical reactions happen\n- Cell membrane: controls what enters/leaves\n- Mitochondria: respiration, releases energy\n- Ribosomes: make proteins\n\n## Plant cells also have:\n- Cell wall (cellulose) - rigid support\n- Chloroplasts - photosynthesis\n- Permanent vacuole - filled with cell sap\n\n## Specialised Cells\n- Red blood cells: biconcave, no nucleus, carry oxygen\n- Nerve cells: long with dendrites, transmit impulses\n- Root hair cells: large surface area for water absorption\n\n## Transport in Cells\n- Diffusion: high -> low concentration (no energy)\n- Osmosis: water across a partially permeable membrane\n- Active transport: low -> high, needs energy (uses carrier proteins)', 51, 3),

  (seed_user_id, 'GCSE Chemistry Revision Guide - Topic 1', 'Chemistry', 10,
   E'# GCSE Chemistry Revision - Atomic Structure\n\n## Atoms\n- Made of protons (+), neutrons (0), electrons (-)\n- Protons + neutrons in nucleus, electrons in shells\n- Atomic number = protons (also = electrons)\n- Mass number = protons + neutrons\n\n## Isotopes\n- Same element, different number of neutrons\n- Same chemical properties, different physical properties\n\n## Electron Configuration\n- Shells fill in order: 2, 8, 8...\n- Sodium (11): 2, 8, 1\n- Chlorine (17): 2, 8, 7\n\n## The Periodic Table\n- Groups = columns (similar properties, same outer electrons)\n- Periods = rows (same number of shells)\n- Metals on left, non-metals on right\n- Group 1: alkali metals (very reactive)\n- Group 7: halogens (react with metals)\n- Group 0: noble gases (unreactive, full outer shell)', 40, 1),

  (seed_user_id, 'GCSE Physics Revision Guide - Topic 1', 'Physics', 10,
   E'# GCSE Physics Revision - Energy\n\n## Energy Stores\n- Kinetic (moving)\n- Gravitational potential (height)\n- Elastic potential (stretched)\n- Thermal (heat)\n- Chemical (batteries, food)\n- Nuclear (atoms)\n\n## Energy Transfers\n- Energy is conserved: never created or destroyed\n- Always transfers to useful + wasted forms\n- Efficiency = (useful output / total input) x 100%\n\n## Kinetic Energy\n- KE = 1/2 x mass x velocity^2\n- Units: Joules (J)\n\n## Gravitational Potential Energy\n- GPE = mass x gravity x height\n- On Earth, g ~ 10 N/kg\n\n## Power\n- Power = energy transferred / time\n- Units: Watts (W) = J/s', 38, 2),

  (seed_user_id, 'A-Level Chemistry Revision - Organic Chemistry', 'Chemistry', 13,
   E'# A-Level Chemistry Revision - Organic Chemistry\n\n## Nomenclature\n- Alkanes: -ane (methane, ethane, propane)\n- Alkenes: -ene (ethene, propene)\n- Alcohols: -ol (ethanol, propanol)\n- Carboxylic acids: -oic acid (ethanoic acid)\n\n## Isomerism\n- Structural: different arrangement of atoms\n- Stereoisomerism: same atoms, different 3D arrangement\n- E/Z isomerism: around a C=C double bond\n- Optical: non-superimposable mirror images\n\n## Reaction Mechanisms\n- Free radical substitution: alkanes + halogens (UV light)\n- Electrophilic addition: alkenes + HBr\n- Nucleophilic substitution: haloalkanes + OH-\n- Elimination: haloalkanes + KOH (ethanol)\n\n## Key Reactions\n- Combustion: alkane + O2 -> CO2 + H2O\n- Dehydration: ethanol -> ethene + water\n- Esterification: alcohol + carboxylic acid -> ester + water', 43, 1),

  (seed_user_id, 'A-Level Maths Revision - Pure Maths Essentials', 'Mathematics', 13,
   E'# A-Level Maths Revision - Pure\n\n## Differentiation\n- Power rule: d/dx(x^n) = nx^(n-1)\n- Chain rule: dy/dx = dy/du x du/dx\n- Product rule: uv = udv/dx + vdu/dx\n- Quotient rule: u/v = (vdu - udv)/v^2\n\n## Integration\n- Reverse of differentiation: x^n -> x^(n+1)/(n+1)\n- Definite integrals give areas under curves\n- Integration by parts: uv dx = uv - vu dx\n\n## Logs & Exponentials\n- e^x differentiates to itself\n- ln(x) differentiates to 1/x\n- ln(ab) = ln(a) + ln(b)\n\n## Key Skill Checklist\n- Solve quadratics (formula, factorising, completing square)\n- Sketch graphs (intercepts, turning points)\n- Find stationary points (dy/dx = 0)\n- Use binomial expansion', 47, 2),

  (seed_user_id, 'GCSE English Language - Exam Technique Guide', 'English', 11,
   E'# GCSE English Language - Exam Technique\n\n## Paper 1: Fiction\n- Q1: List 4 things (1 mark each, 4 minutes)\n- Q2: Language analysis (8 marks, 10 minutes)\n- Q3: Structure analysis (8 marks, 10 minutes)\n- Q4: Evaluate a statement (20 marks, 20 minutes)\n- Q5: Creative writing (40 marks, 45 minutes)\n\n## Paper 2: Non-Fiction\n- Q1: True/false statements\n- Q2: Summary of both sources\n- Q3: Language analysis\n- Q4: Compare viewpoints (16 marks)\n- Q5: Transactional writing (speech, article, letter)\n\n## Language Analysis Phrases\n- The writer uses... to...\n- This implies/suggests...\n- The adjective "x" conveys...\n- This creates the effect of...\n\n## Structure Terms\n- Opening, shift in focus, zoom in/out\n- Repetition, contrast, foreshadowing\n- Cyclical structure, turning point', 56, 3),

  (seed_user_id, 'GCSE History Revision - Weimar & Nazi Germany', 'History', 11,
   E'# GCSE History Revision - Weimar & Nazi Germany 1918-39\n\n## Weimar Republic (1918-1933)\n- Set up after WWI defeat\n- Weaknesses: proportional representation, Article 48\n- Treaty of Versailles 1919: War Guilt, reparations, disarmament\n- Hyperinflation 1923\n- Golden Age 1924-29 (Stresemann)\n\n## Rise of the Nazis\n- Munich Putsch 1923\n- Mein Kampf\n- Wall Street Crash 1929 -> Great Depression\n- Propaganda (Goebbels)\n- Appointed Chancellor January 1933\n\n## Dictatorship 1933-39\n- Reichstag Fire Feb 1933\n- Enabling Act March 1933\n- Night of the Long Knives 1934\n- Hitler becomes Fuhrer 1934\n- Nuremberg Laws 1935\n- Kristallnacht 1938\n\n## Exam Focus\n- Interpretations: both sides of a debate\n- Key individuals: Hitler, Hindenburg, Papen\n- Source analysis: propaganda posters, speeches', 42, 1),

  (seed_user_id, 'GCSE Geography Revision - Natural Hazards', 'Geography', 10,
   E'# GCSE Geography Revision - Natural Hazards\n\n## Tectonic Hazards\n- Plate boundaries: destructive, constructive, conservative\n- Earthquakes: focus, epicentre, magnitude\n- Volcanoes: composite (violent) vs shield (gentle)\n- Primary effects vs secondary effects\n- Short-term responses vs long-term responses\n\n## Weather Hazards\n- Tropical storms: 5 stages, Coriolis effect\n- Saffir-Simpson scale\n- Case study: effects and management\n- UK extreme weather: floods, heatwaves, storms\n\n## Climate Change\n- Causes: greenhouse gases, fossil fuels, deforestation\n- Evidence: ice cores, sea levels, temperature records\n- Effects: sea level rise, extreme weather, habitat loss\n- Mitigation: renewable energy, carbon capture\n- Adaptation: flood defences, drought-resistant crops', 39, 2),

  (seed_user_id, 'Year 7 Maths Study Guide - Number Skills', 'Mathematics', 7,
   E'# Year 7 Maths - Number Skills\n\n## Place Value & Rounding\n- Units, tens, hundreds, thousands\n- Round to nearest 10, 100, 1000\n- Round to 1 or 2 decimal places\n\n## Negative Numbers\n- Adding: same sign, add and keep sign\n- Subtracting: change to addition, flip sign\n- Multiplying/dividing: same sign -> positive, different -> negative\n\n## Fractions\n- Equivalent fractions: multiply/divide top and bottom by same number\n- Simplifying: divide by HCF\n- Adding/subtracting: common denominator\n- Multiplying: top x top, bottom x bottom\n\n## Decimals & Percentages\n- Fraction to decimal: divide\n- Decimal to percentage: multiply by 100\n- 50% = 1/2, 25% = 1/4, 10% = 1/10\n- Percentage of amount: divide by 100, multiply\n\n## Factors & Multiples\n- Factors: divide exactly\n- HCF: largest common factor\n- LCM: smallest common multiple', 33, 1),

  (seed_user_id, 'Year 8 Science Study Guide - Periodic Table Intro', 'Science', 8,
   E'# Year 8 Science - The Periodic Table\n\n## History\n- Mendeleev ordered elements by atomic mass\n- Left gaps for undiscovered elements\n- Modern table ordered by atomic number\n\n## Key Groups\n- Group 1 (Alkali Metals): Li, Na, K\n  - Soft, low density, very reactive\n  - React with water -> fizz + hydrogen\n- Group 7 (Halogens): F, Cl, Br, I\n  - Coloured, reactive non-metals\n  - Reactivity decreases down group\n- Group 0 (Noble Gases): He, Ne, Ar\n  - Unreactive (full outer shell)\n\n## Metals vs Non-Metals\n- Metals: shiny, conduct, malleable\n- Non-metals: dull, insulators\n\n## Patterns\n- Elements in the same group have the same number of outer electrons\n- This is why they react similarly', 30, 1),

  (seed_user_id, 'Year 9 English Study Guide - Analysing Poetry', 'English', 9,
   E'# Year 9 English - How to Analyse a Poem\n\n## Step 1: First Impressions\n- Read the poem twice\n- What is it about? (theme)\n- Who is the speaker? What tone?\n\n## Step 2: Language\n- Simile: like/as\n- Metaphor: direct comparison\n- Personification: human qualities to objects\n- Imagery: descriptive pictures\n- Alliteration: repeated consonant sounds\n\n## Step 3: Structure\n- Stanza length: what does it suggest?\n- Rhyme scheme: regular = control, irregular = chaos\n- Enjambment: lines run on (flow/urgency)\n- Caesura: pause in a line (stops the reader)\n\n## Step 4: Sound\n- Onomatopoeia: words that sound like their meaning\n- Sibilance: soft s sounds (hissing)\n- Assonance: repeated vowel sounds\n\n## Step 5: Write the Analysis\n- Use PEE/PEEL: Point, Evidence, Explain, Link\n- Quote + technique + effect + link to meaning', 36, 2),

  (seed_user_id, 'GCSE Maths - Trigonometry Guide', 'Mathematics', 11,
   E'# GCSE Maths - Trigonometry Guide\n\n## Right-Angled Triangles\n- SOH CAH TOA\n- sin = opposite/hypotenuse\n- cos = adjacent/hypotenuse\n- tan = opposite/adjacent\n\n## Using Trigonometry\n- To find a missing side: choose ratio, substitute, rearrange\n- To find a missing angle: use inverse (sin-1, cos-1, tan-1)\n\n## Exact Values\n- sin(30) = 1/2, cos(60) = 1/2\n- tan(45) = 1\n- sin(60) = sqrt(3)/2, cos(30) = sqrt(3)/2\n\n## Non-Right-Angled Triangles\n- Sine rule: a/sinA = b/sinB\n- Cosine rule: a^2 = b^2 + c^2 - 2bc cosA\n- Area: 1/2 ab sinC\n\n## Pythagoras\n- a^2 + b^2 = c^2 (c = hypotenuse)\n- 3-4-5 triangles, 5-12-13 triangles', 49, 2),

  (seed_user_id, 'A-Level Psychology - Research Methods Guide', 'Psychology', 12,
   E'# A-Level Psychology - Research Methods\n\n## Experiments\n- Laboratory: high control, low ecological validity\n- Field: real-world setting, less control\n- Natural: naturally occurring IV\n\n## Sampling\n- Random, systematic, stratified, opportunity, volunteer\n- Each has strengths and weaknesses\n\n## Data Types\n- Quantitative: numbers, easy to analyse\n- Qualitative: words, rich in detail\n- Primary: collected by researcher\n- Secondary: existing data\n\n## Reliability & Validity\n- Reliability: consistency (test-retest, inter-rater)\n- Validity: measuring what you claim\n- Internal validity: within the study\n- External validity: generalisable\n\n## Ethics\n- Informed consent, deception, right to withdraw\n- Debriefing, confidentiality, protection from harm\n\n## Statistical Tests\n- Choosing a test: level of measurement, experimental design, difference vs correlation\n- Significance: p < 0.05\n- Type I/II errors', 41, 1);

  RAISE NOTICE 'Additional study guides seeded!';
END;
$$;

SELECT seed_more_guides();
DROP FUNCTION seed_more_guides();
