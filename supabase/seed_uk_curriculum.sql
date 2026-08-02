-- UK Curriculum Seed for StudySwap
-- Run this in Supabase SQL Editor AFTER migration.sql

CREATE OR REPLACE FUNCTION seed_uk_curriculum()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  seed_user_id uuid;
  d_id uuid;
BEGIN
  IF EXISTS (SELECT 1 FROM decks WHERE year_group IS NOT NULL LIMIT 1) THEN
    RAISE NOTICE 'Year group data already exists, skipping.';
    RETURN;
  END IF;

  SELECT id INTO seed_user_id FROM auth.users LIMIT 1;
  IF seed_user_id IS NULL THEN
    RAISE NOTICE 'No users found. Please create an account first.';
    RETURN;
  END IF;

  -- =============================================
  -- YEAR 7
  -- =============================================

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Maths - Numbers & Algebra', 'Foundation: number, fractions, decimals, percentages, basic algebra', 'Mathematics', 7, 20, 52, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a prime number?', 'A number greater than 1 that has exactly two factors: 1 and itself (2, 3, 5, 7, 11...)', 0),
  (d_id, 'How do you convert a fraction to a decimal?', 'Divide the numerator by the denominator (e.g. 3/4 = 3 ÷ 4 = 0.75)', 1),
  (d_id, 'What does BODMAS stand for?', 'Brackets, Orders, Division/Multiplication, Addition/Subtraction - the order of operations', 2),
  (d_id, 'What is a negative number multiplied by a negative?', 'A positive result. Negative × Negative = Positive', 3),
  (d_id, 'How do you find 15% of 200?', '15% of 200 = 15/100 × 200 = 30', 4),
  (d_id, 'What is the formula for the area of a rectangle?', 'Area = length × width', 5),
  (d_id, 'What is a ratio?', 'A comparison of two or more quantities (e.g. 3:2 means for every 3 of one, there are 2 of the other)', 6),
  (d_id, 'Simplify the ratio 6:9', 'Divide both by 3 = 2:3', 7),
  (d_id, 'What is 3x + 5 = 20 solved for x?', 'x = 5 (subtract 5 from both sides to get 3x = 15, then divide by 3)', 8),
  (d_id, 'What is the perimeter of a rectangle with length 8cm and width 3cm?', 'Perimeter = 2(l + w) = 2(8 + 3) = 22cm', 9),
  (d_id, 'What is a factor?', 'A number that divides exactly into another number (e.g. factors of 12 are 1, 2, 3, 4, 6, 12)', 10),
  (d_id, 'What is the highest common factor (HCF) of 12 and 18?', '6 - the largest number that divides both 12 and 18', 11),
  (d_id, 'What is the lowest common multiple (LCM) of 4 and 6?', '12 - the smallest number that is a multiple of both 4 and 6', 12),
  (d_id, 'How do you add fractions with different denominators?', 'Find a common denominator first, then add the numerators (e.g. 1/3 + 1/4 = 4/12 + 3/12 = 7/12)', 13),
  (d_id, 'What is 3/4 as a percentage?', '75% (multiply by 100: 3/4 × 100 = 75%)', 14),
  (d_id, 'What is the value of pi (π) to 2 decimal places?', '3.14', 15),
  (d_id, 'What is the area of a triangle?', 'Area = ½ × base × height', 16),
  (d_id, 'What is 2³ ?', '8 (2 × 2 × 2 = 8)', 17),
  (d_id, 'Solve: x + 7 = 15', 'x = 8', 18),
  (d_id, 'What is a multiple?', 'A number in the times table of another number (e.g. multiples of 3: 3, 6, 9, 12...)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Science - Cell Biology & Forces', 'Cells, forces, matter and energy basics', 'Science', 7, 20, 45, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the basic unit of life?', 'The cell', 0),
  (d_id, 'Name two types of cell', 'Plant cells and animal cells', 1),
  (d_id, 'What organelle controls the cell?', 'The nucleus', 2),
  (d_id, 'What does the mitochondria do?', 'Releases energy from glucose through respiration', 3),
  (d_id, 'What is the equation for speed?', 'Speed = distance ÷ time', 4),
  (d_id, 'What is the unit of force?', 'The Newton (N)', 5),
  (d_id, 'What is the unit of speed?', 'Metres per second (m/s) or kilometres per hour (km/h)', 6),
  (d_id, 'What is the density equation?', 'Density = mass ÷ volume', 7),
  (d_id, 'What is photosynthesis?', 'The process by which green plants use sunlight to make glucose from carbon dioxide and water', 8),
  (d_id, 'What is the word equation for photosynthesis?', 'Carbon dioxide + Water → Glucose + Oxygen (with light energy)', 9),
  (d_id, 'What are the three states of matter?', 'Solid, liquid, gas', 10),
  (d_id, 'What happens to particles when a solid melts?', 'They gain energy and start to vibrate more, eventually breaking free from fixed positions', 11),
  (d_id, 'What is a contact force?', 'A force that needs two objects to be touching (e.g. friction, normal force)', 12),
  (d_id, 'What is a non-contact force?', 'A force that acts at a distance (e.g. gravity, magnetism, electrostatic)', 13),
  (d_id, 'What is the main function of root hair cells?', 'To absorb water and minerals from the soil', 14),
  (d_id, 'What does a red blood cell do?', 'Carries oxygen around the body using haemoglobin', 15),
  (d_id, 'What is respiration in cells?', 'The process of releasing energy from glucose (not the same as breathing)', 16),
  (d_id, 'What unit is energy measured in?', 'Joules (J)', 17),
  (d_id, 'What is the largest organ in the human body?', 'The skin', 18),
  (d_id, 'What is the difference between mass and weight?', 'Mass is the amount of matter (kg). Weight is a force due to gravity (N). Weight = mass × gravitational field strength.', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 English - Shakespeare & Poetry', 'Introduction to Shakespeare, grammar, and poetry', 'English', 7, 20, 38, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who was William Shakespeare?', 'An English playwright and poet (1564-1616) who wrote 37 plays and many sonnets', 0),
  (d_id, 'What is a simile?', 'A comparison using like or as (e.g. brave as a lion, fast as lightning)', 1),
  (d_id, 'What is a metaphor?', 'A direct comparison without like or as (e.g. time is money, the world is a stage)', 2),
  (d_id, 'What is personification?', 'Giving human qualities to non-human things (e.g. the wind whispered)', 3),
  (d_id, 'What is alliteration?', 'Repetition of the same consonant sound at the start of nearby words (e.g. Peter Piper picked)', 4),
  (d_id, 'What is a noun?', 'A word that names a person, place, thing or idea (e.g. dog, London, happiness)', 5),
  (d_id, 'What is a verb?', 'A word that describes an action, state or occurrence (e.g. run, think, is)', 6),
  (d_id, 'What is an adjective?', 'A word that describes a noun (e.g. tall, blue, beautiful)', 7),
  (d_id, 'What is an adverb?', 'A word that describes a verb, adjective or another adverb (e.g. quickly, very, carefully)', 8),
  (d_id, 'What is the past progressive tense?', 'Describes an ongoing action in the past (e.g. She was walking to school)', 9),
  (d_id, 'What is a sonnet?', 'A 14-line poem, usually about love, written in iambic pentameter', 10),
  (d_id, 'What is a stanza?', 'A group of lines forming a unit in a poem (like a paragraph in prose)', 11),
  (d_id, 'What is the rhyme scheme?', 'The pattern of rhyming words at the end of each line of a poem', 12),
  (d_id, 'In Romeo and Juliet, who are the two feuding families?', 'The Montagues and the Capulets', 13),
  (d_id, 'What is a pronoun?', 'A word used instead of a noun (e.g. he, she, it, they, we)', 14),
  (d_id, 'What is a conjunction?', 'A word that joins clauses together (e.g. and, but, because, although)', 15),
  (d_id, 'What is the difference between their, there and they are?', 'their = belonging to them, there = a place, they are = they are', 16),
  (d_id, 'What is a simile in Romeo and Juliet example?', '"It is the east, and Juliet is the sun" (metaphor) or "My love is as deep as the ocean" (simile)', 17),
  (d_id, 'What is a formal letter?', 'A letter written to an authority figure or business, using formal language and structure', 18),
  (d_id, 'What is an apostrophe used for?', 'To show possession (the dogs bone) or to indicate missing letters (dont, cant)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 History - Medieval Britain', 'Medieval Britain from 1066 to 1500', 'History', 7, 20, 42, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who won the Battle of Hastings in 1066?', 'William the Conqueror (Duke of Normandy) defeated King Harold II', 0),
  (d_id, 'What was the Domesday Book?', 'A survey of England completed in 1086 by William the Conqueror to record land ownership and value for taxation', 1),
  (d_id, 'What was the feudal system?', 'A hierarchy of loyalty: King → Barons → Knights → Peasants, in exchange for land and protection', 2),
  (d_id, 'What were the main jobs of medieval peasants?', 'Farming, harvesting, looking after animals - most people were peasants', 3),
  (d_id, 'What was a manor?', 'The estate of a lord, including farmland, a village, and the lords house (manor house)', 4),
  (d_id, 'What was the Black Death?', 'A plague that killed roughly 1/3 of Englands population in 1348-1349', 5),
  (d_id, 'What were the effects of the Black Death?', 'Labour shortage, higher wages for peasants, decline of serfdom', 6),
  (d_id, 'What was the Magna Carta?', 'A charter signed in 1215 by King John, limiting the power of the king and establishing rights for barons', 7),
  (d_id, 'Who signed the Magna Carta?', 'King John, at Runnymede in 1215, under pressure from rebellious barons', 8),
  (d_id, 'What was the Hundred Years War?', 'A series of wars between England and France (1337-1453) over land and the French throne', 9),
  (d_id, 'What was the War of the Roses?', 'A civil war (1455-1487) between the House of Lancaster (red rose) and House of York (white rose)', 10),
  (d_id, 'Who became the first Tudor king?', 'Henry VII, after winning the Battle of Bosworth Field in 1485', 11),
  (d_id, 'What was a medieval castle used for?', 'Defence, controlling the local area, and showing the lords power and wealth', 12),
  (d_id, 'What were the three main types of medieval field system?', 'Open fields (strip farming), enclosed fields, and common land', 13),
  (d_id, 'What was a guild?', 'An association of craftsmen or merchants who controlled training, quality, and prices', 14),
  (d_id, 'What language did the Normans bring to England?', 'French, which became the language of the court and law', 15),
  (d_id, 'What was serfdom?', 'A system where peasants were bound to the land and could not leave without the lords permission', 16),
  (d_id, 'What was the Peasants Revolt of 1381?', 'An uprising against the poll tax, led by Wat Tyler, demanding fairer treatment', 17),
  (d_id, 'What was the role of the Church in medieval life?', 'The Church was extremely powerful - it controlled education, healthcare, and spiritual life', 18),
  (d_id, 'What was a joust?', 'A medieval sport where two knights on horseback charged at each other with lances', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Geography - Map Skills & Weather', 'Map skills, weather patterns, and climate', 'Geography', 7, 20, 35, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the four cardinal points on a compass?', 'North, South, East, West', 0),
  (d_id, 'What does a contour line show on a map?', 'Lines of equal height above sea level - closer lines = steeper land', 1),
  (d_id, 'What is the scale on a map?', 'The ratio between distance on the map and real distance on the ground', 2),
  (d_id, 'What is a grid reference?', 'A set of numbers giving the position of a point on a map using grid lines', 3),
  (d_id, 'What is the difference between weather and climate?', 'Weather is the day-to-day conditions. Climate is the average weather over 30+ years.', 4),
  (d_id, 'What are the four main types of precipitation?', 'Rain, snow, sleet, and hail', 5),
  (d_id, 'What causes the water cycle?', 'Evaporation → Condensation → Precipitation → Collection, driven by the suns energy', 6),
  (d_id, 'What is the equator?', 'An imaginary line around the middle of the Earth at 0 degrees latitude', 7),
  (d_id, 'What is the Tropic of Cancer?', '23.5 degrees North of the equator', 8),
  (d_id, 'What is the Tropic of Capricorn?', '23.5 degrees South of the equator', 9),
  (d_id, 'What is a high pressure system associated with?', 'Generally dry, clear, settled weather', 10),
  (d_id, 'What is a low pressure system associated with?', 'Cloudy, wet, windy weather', 11),
  (d_id, 'What are the main wind belts on Earth?', 'Trade winds, westerlies, and polar easterlies', 12),
  (d_id, 'What is the difference between climate zones?', 'Tropical, arid, temperate, continental, and polar - based on temperature and rainfall', 13),
  (d_id, 'What is an Ordnance Survey map?', 'A detailed topographic map of the UK produced by the Ordnance Survey', 14),
  (d_id, 'What is an six-figure grid reference?', 'Gives a precise location: first 3 digits = eastings, second 3 = northings', 15),
  (d_id, 'What is the direction of prevailing UK winds?', 'South-westerly (winds come from the south-west)', 16),
  (d_id, 'What is the difference between a peninsula and an isthmus?', 'A peninsula is land surrounded by water on 3 sides. An isthmus is a narrow strip connecting two larger land masses.', 17),
  (d_id, 'What is an estuary?', 'The tidal mouth of a large river, where the river meets the sea', 18),
  (d_id, 'What is altitude?', 'The height above sea level', 19);

  -- =============================================
  -- YEAR 8
  -- =============================================

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Maths - Ratio, Equations & Geometry', 'Ratio, probability, equations, and geometry', 'Mathematics', 8, 20, 48, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'How do you simplify a ratio?', 'Divide both sides by their highest common factor (e.g. 15:25 = 3:5)', 0),
  (d_id, 'What is probability?', 'The likelihood of an event happening, from 0 (impossible) to 1 (certain)', 1),
  (d_id, 'How do you calculate probability?', 'Probability = number of favourable outcomes ÷ total number of outcomes', 2),
  (d_id, 'What do angles on a straight line add up to?', '180 degrees', 3),
  (d_id, 'What do angles in a triangle add up to?', '180 degrees', 4),
  (d_id, 'What are vertically opposite angles?', 'Angles opposite each other when two lines cross - they are equal', 5),
  (d_id, 'What is Pythagoras theorem?', 'a² + b² = c² (for right-angled triangles, where c is the hypotenuse)', 6),
  (d_id, 'In a right-angled triangle with sides 3cm and 4cm, what is the hypotenuse?', '5cm (3² + 4² = 9 + 16 = 25, √25 = 5)', 7),
  (d_id, 'What is a linear equation?', 'An equation where the variable has a power of 1 (e.g. 2x + 3 = 11)', 8),
  (d_id, 'Solve 3x - 7 = 14', 'x = 7 (add 7 to get 3x = 21, divide by 3)', 9),
  (d_id, 'What is the area of a parallelogram?', 'Area = base × perpendicular height', 10),
  (d_id, 'What is the area of a trapezium?', 'Area = ½ × (a + b) × h, where a and b are the parallel sides', 11),
  (d_id, 'What is the sum of interior angles of a quadrilateral?', '360 degrees', 12),
  (d_id, 'What is the formula for the circumference of a circle?', 'C = πd or C = 2πr', 13),
  (d_id, 'What is the formula for the area of a circle?', 'A = πr²', 14),
  (d_id, 'What is a surd?', 'An irrational number left in square root form (e.g. √2, √3) - not evaluated as a decimal', 15),
  (d_id, 'What is the probability of flipping a coin and getting heads?', '1/2 or 0.5 or 50%', 16),
  (d_id, 'What is a compound event?', 'Two or more events happening together - multiply individual probabilities for independent events', 17),
  (d_id, 'What is the volume of a cuboid?', 'V = length × width × height', 18),
  (d_id, 'What is the volume of a cylinder?', 'V = πr²h (area of circular base × height)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Science - Reproduction & Chemical Reactions', 'Reproduction, chemical reactions, light and sound', 'Science', 8, 20, 41, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is sexual reproduction?', 'Reproduction involving the fusion of male and female gametes to form a zygote', 0),
  (d_id, 'What is asexual reproduction?', 'Reproduction involving only one parent with no fusion of gametes - genetically identical offspring', 1),
  (d_id, 'What is fertilisation?', 'The fusion of a sperm cell and an egg cell to form a zygote', 2),
  (d_id, 'What is a chemical reaction?', 'A process where substances (reactants) are changed into different substances (products)', 3),
  (d_id, 'What are the signs of a chemical change?', 'Colour change, gas produced, temperature change, formation of a precipitate', 4),
  (d_id, 'What is the word equation for photosynthesis?', 'Carbon dioxide + Water → Glucose + Oxygen', 5),
  (d_id, 'What is the word equation for respiration?', 'Glucose + Oxygen → Carbon dioxide + Water + Energy', 6),
  (d_id, 'What is oxidation?', 'A reaction with oxygen - e.g. rusting of iron, burning', 7),
  (d_id, 'What is an acid?', 'A substance with pH less than 7, tastes sour, turns litmus red', 8),
  (d_id, 'What is an alkali?', 'A base that dissolves in water, with pH greater than 7', 9),
  (d_id, 'What happens when an acid reacts with a metal?', 'A salt and hydrogen gas are produced', 10),
  (d_id, 'What is reflection of light?', 'Light bouncing off a smooth surface - angle of incidence = angle of reflection', 11),
  (d_id, 'What is refraction?', 'The bending of light as it passes from one medium to another (e.g. air to water)', 12),
  (d_id, 'What is the speed of light?', 'Approximately 300,000 km/s in a vacuum', 13),
  (d_id, 'What is sound?', 'A vibration that travels as a longitudinal wave through a medium', 14),
  (d_id, 'How does pitch relate to frequency?', 'Higher frequency = higher pitch. Higher frequency means more waves per second.', 15),
  (d_id, 'What is the difference between a concave and convex mirror?', 'Concave mirrors converge light (like a spoon). Convex mirrors diverge light (like a shop security mirror).', 16),
  (d_id, 'What is the pH scale?', 'A scale from 0-14 measuring how acidic or alkaline a substance is. 7 is neutral.', 17),
  (d_id, 'What is carbon dioxide testing?', 'Bubble gas through limewater - if it turns milky/cloudy, CO2 is present', 18),
  (d_id, 'What is electrolysis?', 'Using electricity to break down an ionic compound into its elements', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 History - Tudors & Stuarts', 'The Tudor and Stuart periods in Britain', 'History', 8, 20, 39, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who were the Tudor monarchs?', 'Henry VII, Henry VIII, Edward VI, Mary I, Elizabeth I (1485-1603)', 0),
  (d_id, 'Why did Henry VIII break with Rome?', 'To divorce Catherine of Aragon and marry Anne Boleyn when the Pope refused', 1),
  (d_id, 'What was the English Reformation?', 'Henry VIII establishing the Church of England separate from the Catholic Church', 2),
  (d_id, 'How many wives did Henry VIII have?', 'Six: Catherine of Aragon, Anne Boleyn, Jane Seymour, Anne of Cleves, Catherine Howard, Catherine Parr', 3),
  (d_id, 'Who was Elizabeth I?', 'Queen of England (1558-1603), daughter of Henry VIII and Anne Boleyn', 4),
  (d_id, 'What was the Spanish Armada?', 'The Spanish fleet sent to invade England in 1588 - defeated by English navy and bad weather', 5),
  (d_id, 'Who was Shakespeare during Elizabeth I reign?', 'The greatest playwright of the era, writing for the Globe Theatre', 6),
  (d_id, 'What was the Gunpowder Plot of 1605?', 'Guy Fawkes attempt to blow up Parliament and kill King James I', 7),
  (d_id, 'Who were the Stuarts?', 'James I, Charles I, Cromwell (Commonwealth), Charles II, James II, William & Mary, Anne', 8),
  (d_id, 'What was the English Civil War?', 'War between Parliamentarians (Roundheads) and Royalists (Cavaliers) 1642-1651', 9),
  (d_id, 'Who was Oliver Cromwell?', 'Leader of the Roundheads who became Lord Protector of England after the Civil War', 10),
  (d_id, 'What happened to Charles I?', 'He was executed in 1649 outside the Banqueting House in Whitehall', 11),
  (d_id, 'What was the Restoration?', 'The return of the monarchy in 1660 with Charles II becoming king', 12),
  (d_id, 'What was the Great Fire of London?', 'A fire in 1666 that destroyed most of medieval London, starting in a bakery on Pudding Lane', 13),
  (d_id, 'What was the Glorious Revolution?', 'The peaceful overthrow of James II in 1688, replacing him with William III and Mary II', 14),
  (d_id, 'What was the Bill of Rights (1689)?', 'A law limiting the power of the monarch and establishing the rights of Parliament', 15),
  (d_id, 'Why was Elizabeth I called the Virgin Queen?', 'She never married, claiming to be married to England', 16),
  (d_id, 'What was the role of the Privy Council?', 'Advisors to the monarch who helped govern the country', 17),
  (d_id, 'What was the Poor Law?', 'Legislation to deal with poverty - the 1601 Poor Law forced parishes to care for the poor', 18),
  (d_id, 'What was the significance of the Acts of Union 1707?', 'United England and Scotland into Great Britain', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Geography - Ecosystems & Tectonics', 'Ecosystems, plate tectonics, and natural hazards', 'Geography', 8, 20, 36, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is an ecosystem?', 'A community of living organisms (biotic) interacting with non-living (abiotic) components', 0),
  (d_id, 'What is a food chain?', 'A linear sequence showing energy transfer from producers to consumers', 1),
  (d_id, 'What is a producer?', 'An organism that makes its own food, usually a plant using photosynthesis', 2),
  (d_id, 'What is a consumer?', 'An organism that eats other organisms for energy', 3),
  (d_id, 'What is a decomposer?', 'An organism that breaks down dead organic matter (e.g. bacteria, fungi)', 4),
  (d_id, 'What are the layers of the Earth?', 'Crust, mantle, outer core, inner core', 5),
  (d_id, 'What are tectonic plates?', 'Large pieces of the Earths lithosphere that move slowly on the semi-molten asthenosphere', 6),
  (d_id, 'What causes earthquakes?', 'The sudden release of energy when tectonic plates move past, away from, or towards each other', 7),
  (d_id, 'What is the Richter scale?', 'A scale measuring the magnitude (strength) of an earthquake', 8),
  (d_id, 'What is a volcano?', 'An opening in the Earths crust where magma, ash, and gases escape', 9),
  (d_id, 'What is the difference between magma and lava?', 'Magma is molten rock underground. Lava is magma that has reached the surface.', 10),
  (d_id, 'What is a destructive plate boundary?', 'Where an oceanic plate meets a continental plate and one subducts under the other, forming volcanoes', 11),
  (d_id, 'What is a conservative plate boundary?', 'Where plates slide past each other - no creation or destruction of crust, but earthquakes occur', 12),
  (d_id, 'What is a constructive plate boundary?', 'Where plates move apart and new crust is created (e.g. mid-Atlantic ridge)', 13),
  (d_id, 'What is deforestation?', 'The clearing of forests, often for agriculture, which reduces biodiversity and contributes to climate change', 14),
  (d_id, 'What is the water cycle?', 'The continuous movement of water: evaporation → condensation → precipitation → collection', 15),
  (d_id, 'What is biodiversity?', 'The variety of living organisms in a particular area or ecosystem', 16),
  (d_id, 'What is an abiotic factor?', 'A non-living component of an ecosystem (e.g. temperature, rainfall, sunlight, soil type)', 17),
  (d_id, 'What is a biotic factor?', 'A living component of an ecosystem (e.g. plants, animals, bacteria)', 18),
  (d_id, 'What is a tropical rainforest?', 'A hot, wet biome near the equator with high biodiversity and layers (emergent, canopy, understory, forest floor)', 19);

  -- =============================================
  -- YEAR 9 (Pre-GCSE)
  -- =============================================

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Maths - Indices, Standard Form & Quadratics', 'Pre-GCSE: indices, standard form, quadratic expressions', 'Mathematics', 9, 20, 55, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the laws of indices?', 'When multiplying: add powers. When dividing: subtract powers. When raising to a power: multiply powers.', 0),
  (d_id, 'What is x⁰ equal to?', '1 (any non-zero number to the power of 0 equals 1)', 1),
  (d_id, 'What is x⁻¹ equal to?', '1/x (negative index means reciprocal)', 2),
  (d_id, 'What is 3 × 10⁴ in standard form?', '30,000 (move the decimal point 4 places to the right)', 3),
  (d_id, 'What is 45,000 in standard form?', '4.5 × 10⁴', 4),
  (d_id, 'What is 0.007 in standard form?', '7 × 10⁻³', 5),
  (d_id, 'What is a quadratic expression?', 'An expression with x² as the highest power (e.g. x² + 3x + 2)', 6),
  (d_id, 'How do you factorise x² + 5x + 6?', '(x + 2)(x + 3) - find two numbers that multiply to 6 and add to 5', 7),
  (d_id, 'What is the difference of two squares?', 'a² - b² = (a + b)(a - b) (e.g. x² - 9 = (x + 3)(x - 3))', 8),
  (d_id, 'What is the midpoint formula?', 'Midpoint = ((x₁ + x₂)/2, (y₁ + y₂)/2)', 9),
  (d_id, 'What is the gradient formula?', 'Gradient = (y₂ - y₁) / (x₂ - x₁) = rise / run', 10),
  (d_id, 'What is the equation of a straight line?', 'y = mx + c, where m is the gradient and c is the y-intercept', 11),
  (d_id, 'What is the nth term of 3, 6, 9, 12...?', '3n (each term is 3 times its position)', 12),
  (d_id, 'What is a sequence?', 'A set of numbers following a pattern or rule', 13),
  (d_id, 'How do you expand (x + 3)(x + 2)?', 'x² + 2x + 3x + 6 = x² + 5x + 6', 14),
  (d_id, 'What is 2⁻² ?', '1/4 (2⁻² = 1/2² = 1/4)', 15),
  (d_id, 'What is (2³)² ?', '2⁶ = 64 (multiply the powers: 3 × 2 = 6)', 16),
  (d_id, 'Simplify √50', '5√2 (√50 = √(25 × 2) = 5√2)', 17),
  (d_id, 'What is a simultaneous equation?', 'Two equations with two unknowns solved together (substitution or elimination)', 18),
  (d_id, 'Solve: 2x + y = 7 and x + y = 4', 'x = 3, y = 1 (subtract second from first: x = 3, then y = 4 - 3 = 1)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Science - Energy, Reactions & Inheritance', 'Energy transfers, chemical reactions, genetics', 'Science', 9, 20, 47, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the law of conservation of energy?', 'Energy cannot be created or destroyed, only transferred or transformed', 0),
  (d_id, 'What are the forms of energy?', 'Kinetic, potential (gravitational, elastic, chemical, thermal), nuclear, sound, light, electrical', 1),
  (d_id, 'What is kinetic energy?', 'The energy of movement. KE = ½mv²', 2),
  (d_id, 'What is gravitational potential energy?', 'Energy stored due to height. GPE = mass × gravity × height', 3),
  (d_id, 'What is efficiency?', 'Efficiency = (useful energy output / total energy input) × 100%', 4),
  (d_id, 'What is a chemical equation?', 'A symbolic representation of a chemical reaction using formulas (e.g. 2H₂ + O₂ → 2H₂O)', 5),
  (d_id, 'What is a balanced equation?', 'An equation where the number of atoms of each element is the same on both sides', 6),
  (d_id, 'What is the law of conservation of mass?', 'Mass is neither created nor destroyed in a chemical reaction', 7),
  (d_id, 'What is relative atomic mass?', 'The average mass of an atoms of an element compared to 1/12 of carbon-12', 8),
  (d_id, 'What is the mole concept?', 'One mole = 6.022 × 10²³ particles (Avogadros number)', 9),
  (d_id, 'What is DNA?', 'Deoxyribonucleic acid - the molecule that carries genetic information', 10),
  (d_id, 'What is a gene?', 'A section of DNA that codes for a specific protein', 11),
  (d_id, 'What is a chromosome?', 'A long DNA molecule with many genes, found in the nucleus', 12),
  (d_id, 'How many chromosomes do humans have?', '46 (23 pairs)', 13),
  (d_id, 'What is an allele?', 'An alternative form of a gene (e.g. the gene for eye colour has alleles for blue, brown, green)', 14),
  (d_id, 'What is a dominant allele?', 'An allele that is expressed even when only one copy is present (shown with capital letter)', 15),
  (d_id, 'What is a recessive allele?', 'An allele that is only expressed when two copies are present (shown with lowercase letter)', 16),
  (d_id, 'What is the genotype?', 'The genetic makeup of an organism (e.g. BB, Bb, bb)', 17),
  (d_id, 'What is the phenotype?', 'The observable characteristics of an organism (e.g. brown eyes)', 18),
  (d_id, 'What are chromosomes made of?', 'DNA coiled around histone proteins', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 English - War Poetry & An Inspector Calls', 'War poetry, An Inspector Calls, non-fiction', 'English', 9, 20, 43, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who wrote Dulce et Decorum Est?', 'Wilfred Owen - a WWI poet who experienced trench warfare firsthand', 0),
  (d_id, 'What does Dulce et Decorum Est mean?', '"It is sweet and fitting" - from Horace, used ironically to criticise propaganda', 1),
  (d_id, 'What is the message of Dulce et Decorum Est?', 'That war is horrific and it is a lie to say dying for your country is glorious', 2),
  (d_id, 'Who wrote The Charge of the Light Brigade?', 'Alfred Lord Tennyson - about a disastrous cavalry charge in the Crimean War', 3),
  (d_id, 'What literary devices are used in war poetry?', 'Simile, metaphor, personification, imagery, alliteration, sibilance, enjambment', 4),
  (d_id, 'Who wrote An Inspector Calls?', 'J.B. Priestley, set in 1912 but written in 1945', 5),
  (d_id, 'What is the main theme of An Inspector Calls?', 'Social responsibility - every person is responsible for the welfare of others', 6),
  (d_id, 'Who is the Inspector in An Inspector Calls?', 'A mysterious inspector who investigates the death of Eva Smith - possibly supernatural', 7),
  (d_id, 'What is the Birlings social class?', 'Upper-middle class - Mr Birling is a factory owner and local politician', 8),
  (d_id, 'What is dramatic irony in An Inspector Calls?', 'The audience knows things the characters dont - e.g. Birling says the Titanic is unsinkable', 9),
  (d_id, 'What is a non-fiction text?', 'A text based on facts and real events (articles, speeches, reports, biographies)', 10),
  (d_id, 'What is the purpose of a persuasive text?', 'To convince the reader to agree with a particular viewpoint or take action', 11),
  (d_id, 'What techniques are used in persuasive writing?', 'Rhetorical questions, rule of three, emotive language, statistics, expert opinions, imperative verbs', 12),
  (d_id, 'What is the structure of a newspaper article?', 'Headline → Introduction (who/what/where/when/why) → Detailed paragraphs → Conclusion', 13),
  (d_id, 'What is the difference between fact and opinion?', 'Fact: a statement that can be verified. Opinion: a personal belief or judgement.', 14),
  (d_id, 'What is an autobiography?', 'A written account of a persons life written by that person', 15),
  (d_id, 'What is a diary entry structure?', 'Date, formal/informal tone, chronological account, personal reflections', 16),
  (d_id, 'What is a speech transcript?', 'The written form of a spoken address, including rhetorical devices and structural features', 17),
  (d_id, 'What are the themes of war poetry?', 'Horror of war, loss of innocence, propaganda vs reality, brotherhood, death', 18),
  (d_id, 'What is enjambment?', 'When a sentence continues beyond the end of a line without punctuation', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 History - WWI & the Interwar Period', 'World War I and the interwar period', 'History', 9, 20, 44, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What event started WWI?', 'The assassination of Archduke Franz Ferdinand of Austria-Hungary in Sarajevo, June 1914', 0),
  (d_id, 'What was the alliance system?', 'Europe was divided into two alliance groups: Triple Entente (Britain, France, Russia) and Triple Alliance (Germany, Austria-Hungary, Italy)', 1),
  (d_id, 'What was trench warfare?', 'A form of fighting where soldiers dug trenches and faced each other across No Mans Land', 2),
  (d_id, 'What was No Mans Land?', 'The dangerous ground between opposing trenches, filled with barbed wire and mud', 3),
  (d_id, 'What new weapons were used in WWI?', 'Machine guns, poison gas, tanks, aeroplanes, U-boats, flamethrowers', 4),
  (d_id, 'What was the Battle of the Somme?', 'A 1916 battle with over 1 million casualties; 57,000 British casualties on the first day alone', 5),
  (d_id, 'What was the Armistice?', 'The agreement to stop fighting, signed on 11th November 1918 at 11am', 6),
  (d_id, 'What was the Treaty of Versailles (1919)?', 'The peace treaty that ended WWI - Germany was forced to accept blame, pay reparations, and reduce its military', 7),
  (d_id, 'What were the four terms of Versailles?', 'War Guilt Clause, Reparations, Territorial losses, Military restrictions', 8),
  (d_id, 'What was the League of Nations?', 'An international organisation formed after WWI to maintain peace - the USA never joined', 9),
  (d_id, 'Why did the Weimar Republic fail?', 'Treaty of Versailles, hyperinflation (1923), Great Depression (1929), political extremism', 10),
  (d_id, 'What was hyperinflation?', 'When money loses value so quickly that prices rise massively (1923 Germany: a loaf of bread cost billions of marks)', 11),
  (d_id, 'What was the Wall Street Crash?', 'The stock market crash of October 1929 that triggered the Great Depression worldwide', 12),
  (d_id, 'What was the Great Depression?', 'A worldwide economic downturn from 1929-1939 with mass unemployment and poverty', 13),
  (d_id, 'Who was Adolf Hitler?', 'Leader of the Nazi Party who became Chancellor of Germany in 1933', 14),
  (d_id, 'What was the Nazi Party (NSDAP)?', 'The National Socialist German Workers Party - a far-right, antisemitic political party', 15),
  (d_id, 'What was the Enabling Act (1933)?', 'A law that gave Hitler dictatorial powers, allowing him to pass laws without the Reichstag', 16),
  (d_id, 'What was Kristallnacht?', '"Night of Broken Glass" - a violent pogrom against Jews in November 1938', 17),
  (d_id, 'What was Appeasement?', 'The policy of giving in to Hitlers demands to avoid war, led by PM Neville Chamberlain', 18),
  (d_id, 'When did WWII start?', '3rd September 1939, when Britain and France declared war on Germany after the invasion of Poland', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Geography - Urbanisation & Development', 'Urbanisation, global development, and migration', 'Geography', 9, 20, 37, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is urbanisation?', 'The increasing proportion of people living in towns and cities', 0),
  (d_id, 'What is rural-urban migration?', 'Movement of people from the countryside to towns and cities', 1),
  (d_id, 'What are push factors for migration?', 'Reasons to leave: poverty, lack of jobs, natural disasters, conflict, poor services', 2),
  (d_id, 'What are pull factors for migration?', 'Reasons to move somewhere: jobs, better services, safety, education', 3),
  (d_id, 'What is a megacity?', 'A city with a population of more than 10 million', 4),
  (d_id, 'What is the difference between a developed and developing country?', 'Developed: high GDP, good services, high life expectancy. Developing: lower GDP, poorer infrastructure.', 5),
  (d_id, 'What is GDP per capita?', 'Gross Domestic Product divided by population - average income per person', 6),
  (d_id, 'What is the Human Development Index (HDI)?', 'A measure combining life expectancy, education, and income to rank countries', 7),
  (d_id, 'What is an informal settlement?', 'Unplanned housing built by people without permission (e.g. favelas in Brazil, shanty towns)', 8),
  (d_id, 'What are the problems of rapid urbanisation?', 'Overcrowding, pollution, traffic, inadequate water/sanitation, unemployment, crime', 9),
  (d_id, 'What is sustainable development?', 'Development that meets present needs without compromising future generations', 10),
  (d_id, 'What is globalisation?', 'The increasing interconnectedness of countries through trade, culture, and technology', 11),
  (d_id, 'What is a sweatshop?', 'A factory with poor working conditions, low pay, and long hours, often in developing countries', 12),
  (d_id, 'What is fair trade?', 'A system ensuring producers in developing countries receive a fair price for their products', 13),
  (d_id, 'What is the difference between immigration and emigration?', 'Immigration = moving into a country. Emigration = moving out of a country.', 14),
  (d_id, 'What is counter-urbanisation?', 'The movement of people from cities to rural areas or smaller towns', 15),
  (d_id, 'What is a squatter settlement?', 'Illegal housing built on land that the occupants do not own', 16),
  (d_id, 'What is the difference between a refugee and an asylum seeker?', 'A refugee has been granted protection. An asylum seeker is waiting for a decision on their claim.', 17),
  (d_id, 'What is the population pyramid?', 'A graph showing the age and sex distribution of a population', 18),
  (d_id, 'What causes population growth?', 'Birth rate > death rate, and/or net migration (more immigration than emigration)', 19);

  -- =============================================
  -- YEAR 10 (GCSE Year 1)
  -- =============================================

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Maths Year 10 - Equations & Trigonometry', 'Simultaneous equations, trigonometry, Pythagoras, sequences', 'Mathematics', 10, 20, 62, 5)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is sin(30)?', '0.5 or 1/2', 0),
  (d_id, 'What is cos(60)?', '0.5 or 1/2', 1),
  (d_id, 'What is tan(45)?', '1', 2),
  (d_id, 'What is SOH CAH TOA?', 'SOH: Sin = Opp/Hyp, CAH: Cos = Adj/Hyp, TOA: Tan = Opp/Adj', 3),
  (d_id, 'In a right triangle, if the opposite side is 5 and hypotenuse is 10, what is sin θ?', 'sin θ = 5/10 = 0.5, so θ = 30°', 4),
  (d_id, 'What is the quadratic formula?', 'x = (-b ± √(b²-4ac)) / 2a', 5),
  (d_id, 'Solve x² - 5x + 6 = 0', 'x = 2 or x = 3 (factorise: (x-2)(x-3) = 0)', 6),
  (d_id, 'What is the discriminant?', 'b² - 4ac: tells you the number of real solutions (>0 two, =0 one, <0 none)', 7),
  (d_id, 'What is a geometric sequence?', 'A sequence where each term is multiplied by a constant ratio (e.g. 2, 6, 18, 54... ×3)', 8),
  (d_id, 'What is an arithmetic sequence?', 'A sequence where each term has the same difference added (e.g. 3, 7, 11, 15... +4)', 9),
  (d_id, 'What is the nth term of 2, 4, 6, 8...?', '2n (even numbers)', 10),
  (d_id, 'What is the nth term of 5, 8, 11, 14...?', '3n + 2', 11),
  (d_id, 'What is Pythagoras theorem?', 'a² + b² = c² (hypotenuse squared equals sum of the other two sides squared)', 12),
  (d_id, 'What is the cosine rule?', 'a² = b² + c² - 2bc·cos(A) - for non-right-angled triangles', 13),
  (d_id, 'What is the sine rule?', 'a/sin(A) = b/sin(B) = c/sin(C)', 14),
  (d_id, 'What is simultaneous elimination?', 'Subtracting equations to eliminate one variable, then solving', 15),
  (d_id, 'What is the area of a sector?', 'A = (θ/360) × πr²', 16),
  (d_id, 'What is the arc length formula?', 'L = (θ/360) × 2πr', 17),
  (d_id, 'What are bounds in measurement?', 'The upper and lower limits of a rounded number (e.g. 5.3 to 1dp: 5.25 ≤ x < 5.35)', 18),
  (d_id, 'What is compound interest?', 'A = P(1 + r/100)ⁿ where P is principal, r is rate, n is number of periods', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Biology Year 10 - Cells, Organisation & Infection', 'Cell biology, organisation, infection and response', 'Biology', 10, 20, 58, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the difference between plant and animal cells?', 'Plant cells have: cell wall, chloroplasts, permanent vacuole. Animal cells dont.', 0),
  (d_id, 'What is the function of the nucleus?', 'Contains DNA/genetic material, controls cell activities', 1),
  (d_id, 'What is the function of mitochondria?', 'Site of aerobic respiration - releases energy from glucose', 2),
  (d_id, 'What is the function of ribosomes?', 'Site of protein synthesis', 3),
  (d_id, 'What is osmosis?', 'The movement of water molecules across a partially permeable membrane from high to low water potential', 4),
  (d_id, 'What is active transport?', 'Movement of molecules against the concentration gradient using energy from respiration', 5),
  (d_id, 'What is diffusion?', 'The net movement of particles from high to low concentration', 6),
  (d_id, 'What are the levels of organisation in the body?', 'Cells → Tissues → Organs → Organ systems → Organisms', 7),
  (d_id, 'What are the four main tissue types?', 'Epithelial, connective, muscle, nervous', 8),
  (d_id, 'What is the function of the digestive system?', 'To break down food into nutrients that can be absorbed into the bloodstream', 9),
  (d_id, 'What are enzymes?', 'Biological catalysts - proteins that speed up chemical reactions in the body', 10),
  (d_id, 'What is the lock and key model for enzymes?', 'The substrate fits exactly into the enzyme active site, like a key in a lock', 11),
  (d_id, 'What is the optimum temperature for human enzymes?', '37°C - body temperature', 12),
  (d_id, 'What is a pathogen?', 'An organism that causes disease (bacteria, viruses, fungi, protists)', 13),
  (d_id, 'What is the difference between bacteria and viruses?', 'Bacteria are living cells that can reproduce independently. Viruses need a host cell to reproduce.', 14),
  (d_id, 'What is the immune system?', 'The body system that defends against pathogens using white blood cells', 15),
  (d_id, 'What are antibodies?', 'Proteins produced by white blood cells that bind to specific antigens on pathogens', 16),
  (d_id, 'What is a vaccine?', 'A preparation containing weakened/dead pathogens that stimulates antibody production without causing disease', 17),
  (d_id, 'What is herd immunity?', 'When a large proportion of a population is immune, protecting those who are not', 18),
  (d_id, 'What are antibiotics?', 'Medicines that kill or stop the growth of bacteria (not effective against viruses)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Chemistry Year 10 - Atoms, Bonding & Quantitative', 'Atomic structure, bonding, quantitative chemistry', 'Chemistry', 10, 20, 56, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the subatomic particles?', 'Protons (positive), neutrons (neutral), electrons (negative)', 0),
  (d_id, 'Where are electrons found?', 'In energy levels/shells around the nucleus', 1),
  (d_id, 'What is the atomic number?', 'The number of protons in the nucleus - defines the element', 2),
  (d_id, 'What is the mass number?', 'The total number of protons and neutrons in the nucleus', 3),
  (d_id, 'How do you find neutrons?', 'Mass number - Atomic number = number of neutrons', 4),
  (d_id, 'What is an isotope?', 'Atoms of the same element with different numbers of neutrons (same atomic number, different mass number)', 5),
  (d_id, 'What is electron configuration?', 'The arrangement of electrons in energy levels (2, 8, 18...)', 6),
  (d_id, 'How do you write the electron configuration for Chlorine (17)?', '2, 8, 7', 7),
  (d_id, 'What is an ionic bond?', 'Transfer of electrons from a metal to a non-metal, forming ions that attract each other', 8),
  (d_id, 'What is a covalent bond?', 'Sharing of electrons between non-metal atoms', 9),
  (d_id, 'What is a metal bond?', 'A lattice of positive metal ions in a sea of delocalised electrons', 10),
  (d_id, 'What is the formula for moles?', 'Moles = mass (g) ÷ molar mass (g/mol)', 11),
  (d_id, 'What is the molar mass of water (H₂O)?', '18 g/mol (2×1 + 16 = 18)', 12),
  (d_id, 'What is concentration in mol/dm³?', 'Concentration = moles ÷ volume (in dm³)', 13),
  (d_id, 'What is the volume of 1 mole of gas at room temperature?', '24 dm³ (or 24,000 cm³)', 14),
  (d_id, 'How do you calculate percentage yield?', 'Percentage yield = (actual yield ÷ theoretical yield) × 100%', 15),
  (d_id, 'What is the atom economy?', 'Atom economy = (mass of desired product ÷ total mass of reactants) × 100%', 16),
  (d_id, 'What is a Lewis dot structure?', 'A diagram showing the outer electrons of atoms as dots around the element symbol', 17),
  (d_id, 'What is electronegativity?', 'The ability of an atom to attract electrons in a bond', 18),
  (d_id, 'What makes a substance have a high melting point?', 'Strong bonds/forces between particles (e.g. ionic compounds, metals, giant covalent structures)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Physics Year 10 - Forces, Energy & Waves', 'Forces, energy stores, and wave types', 'Physics', 10, 20, 54, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is Newton Second Law?', 'F = ma (Force = mass × acceleration)', 0),
  (d_id, 'What is the unit of force?', 'The Newton (N) = kg × m/s²', 1),
  (d_id, 'What are the four forces acting on a falling object?', 'Weight (down), air resistance (up), when equal: terminal velocity reached', 2),
  (d_id, 'What is weight?', 'W = mg (mass × gravitational field strength, g ≈ 10 N/kg on Earth)', 3),
  (d_id, 'What is work done?', 'W = F × d (Force × distance moved in the direction of the force)', 4),
  (d_id, 'What is a moment?', 'Moment = Force × perpendicular distance from the pivot', 5),
  (d_id, 'What is the principle of moments?', 'For equilibrium: sum of clockwise moments = sum of anticlockwise moments', 6),
  (d_id, 'What is power?', 'P = W/t (Energy transferred ÷ time taken)', 7),
  (d_id, 'What are the main energy stores?', 'Kinetic, gravitational potential, elastic potential, thermal, chemical, magnetic, electrostatic, nuclear', 8),
  (d_id, 'What is the law of conservation of energy?', 'Energy cannot be created or destroyed, only transferred or stored', 9),
  (d_id, 'What is efficiency?', 'Efficiency = (useful energy output ÷ total energy input) × 100%', 10),
  (d_id, 'What is a transverse wave?', 'A wave where the oscillations are perpendicular to the direction of energy transfer (e.g. light, water waves)', 11),
  (d_id, 'What is a longitudinal wave?', 'A wave where the oscillations are parallel to the direction of energy transfer (e.g. sound, seismic P-waves)', 12),
  (d_id, 'What is the equation for wave speed?', 'v = f × λ (wave speed = frequency × wavelength)', 13),
  (d_id, 'What is frequency?', 'The number of waves per second, measured in Hertz (Hz)', 14),
  (d_id, 'What is wavelength?', 'The distance between two identical points on consecutive waves, measured in metres', 15),
  (d_id, 'What is the electromagnetic spectrum (in order)?', 'Radio, microwave, infrared, visible light, ultraviolet, X-ray, gamma (increasing frequency)', 16),
  (d_id, 'What are the uses of different EM waves?', 'Radio: comms, Microwave: cooking, IR: heating, UV: sterilisation, X-ray: medical, Gamma: cancer treatment', 17),
  (d_id, 'What is the difference between speed and velocity?', 'Speed is a scalar (just magnitude). Velocity is a vector (magnitude and direction).', 18),
  (d_id, 'What is acceleration?', 'a = (v - u) / t (change in velocity ÷ time)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE English Lit Year 10 - Macbeth', 'Shakespeares Macbeth - key quotes, characters, themes', 'English', 10, 20, 65, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who wrote Macbeth?', 'William Shakespeare, c. 1606', 0),
  (d_id, 'Who is the protagonist?', 'Macbeth - a Scottish general who becomes King through murder', 1),
  (d_id, 'Who is the antagonist?', 'Macbeth himself (and Lady Macbeth as an instigator)', 2),
  (d_id, 'What is the witches prophecy?', 'Macbeth will be Thane of Cawdor and then King; Banquo will be father of kings', 3),
  (d_id, '"Fair is foul, and foul is fair" - who says this?', 'The witches (Act 1, Scene 1) - introduces the theme of appearances being deceptive', 4),
  (d_id, '"Is this a dagger which I see before me?" - what does it show?', 'Macbeth hallucinating before murdering Duncan - his guilt and mental deterioration', 5),
  (d_id, '"Out, damned spot!" - who says this?', 'Lady Macbeth - sleepwalking and trying to wash imaginary blood from her hands', 6),
  (d_id, 'What does the dagger symbolise?', 'Macbeths ambition and the moral choice between right and wrong', 7),
  (d_id, 'What does blood symbolise?', 'Guilt, innocence, violence, and the consequences of murder', 8),
  (d_id, 'What does darkness symbolise?', 'Evil, secrecy, and the characters attempts to hide their deeds', 9),
  (d_id, 'What is the theme of ambition?', 'Unchecked ambition leads to destruction - both Macbeth and Lady Macbeth are consumed by it', 10),
  (d_id, 'What is the theme of guilt?', 'Guilt destroys both Macbeth (hallucinations) and Lady Macbeth (madness and suicide)', 11),
  (d_id, 'What is the theme of appearance vs reality?', 'Characters hide true intentions behind false appearances (Macbeth: "look like the innocent flower")', 12),
  (d_id, 'Who is Banquo?', 'Macbeths friend who is warned about Macbeth but is eventually murdered', 13),
  (d_id, 'Who is Macduff?', 'The Thane of Fife who kills Macbeth to restore order to Scotland', 14),
  (d_id, 'Who is the rightful king at the end?', 'Malcolm, the son of King Duncan', 15),
  (d_id, 'What is a tragic hero?', 'A noble character with a fatal flaw (hamartia) who falls from grace', 16),
  (d_id, 'What is Macbeths fatal flaw?', 'His ambition ("vaulting ambition which oerleaps itself")', 17),
  (d_id, 'What is the significance of sleep in the play?', 'Sleep represents innocence and peace - after killing Duncan, Macbeth says he has "murdered sleep"', 18),
  (d_id, 'What is the play about overall?', 'The corrupting power of unchecked ambition and the consequences of acting on immoral desires', 19);

  -- =============================================
  -- YEAR 11 (GCSE Year 2 - Exam Year)
  -- =============================================

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Maths Year 11 - Circle Theorems & Vectors', 'Circle theorems, vectors, histograms, probability', 'Mathematics', 11, 20, 70, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Circle theorem 1: Angle at centre?', 'The angle at the centre is twice the angle at the circumference (subtended by the same arc)', 0),
  (d_id, 'Circle theorem 2: Angle in a semicircle?', 'The angle in a semicircle is always 90°', 1),
  (d_id, 'Circle theorem 3: Angles in the same segment?', 'Angles subtended by the same arc at the circumference are equal', 2),
  (d_id, 'Circle theorem 4: Opposite angles in a cyclic quadrilateral?', 'They add up to 180°', 3),
  (d_id, 'Circle theorem 5: Tangent and radius?', 'A tangent is perpendicular to the radius at the point of contact (90°)', 4),
  (d_id, 'Circle theorem 6: Two tangents from an external point?', 'They are equal in length', 5),
  (d_id, 'What is a vector?', 'A quantity with both magnitude (size) and direction, shown as an arrow', 6),
  (d_id, 'How do you add vectors?', 'Join them tip to tail, or add components: (a,b) + (c,d) = (a+c, b+d)', 7),
  (d_id, 'What is the magnitude of vector (3, 4)?', '√(3² + 4²) = √25 = 5', 8),
  (d_id, 'What is a histogram?', 'A frequency diagram with unequal class widths where area represents frequency', 9),
  (d_id, 'How do you calculate frequency density?', 'Frequency density = frequency ÷ class width', 10),
  (d_id, 'What is a tree diagram?', 'A diagram showing all possible outcomes of multi-stage events', 11),
  (d_id, 'What is conditional probability?', 'The probability of an event given that another event has occurred: P(A|B)', 12),
  (d_id, 'What is the formula for probability of A or B?', 'P(A or B) = P(A) + P(B) - P(A and B)', 13),
  (d_id, 'What is a set in probability?', 'A collection of items (elements), shown in Venn diagrams', 14),
  (d_id, 'What does A union B mean?', 'All elements in A or B or both (A ∪ B)', 15),
  (d_id, 'What does A intersect B mean?', 'Elements in both A and B (A ∩ B)', 16),
  (d_id, 'What is the equation of a circle?', '(x - a)² + (y - b)² = r², where (a,b) is the centre and r is radius', 17),
  (d_id, 'What is a relative frequency?', 'The number of times an event occurs divided by the total number of trials', 18),
  (d_id, 'What is expected frequency?', 'Expected frequency = total trials × probability of the event', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Biology Year 11 - Homeostasis, Ecology & Inheritance', 'Homeostasis, ecology, inheritance and variation', 'Biology', 11, 20, 60, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is homeostasis?', 'The regulation of internal conditions to maintain optimal functioning for enzyme action and cell function', 0),
  (d_id, 'What is the role of the hypothalamus?', 'The part of the brain that detects changes in blood temperature, glucose, and water levels', 1),
  (d_id, 'What is negative feedback?', 'A mechanism where a change triggers a response that reverses the change, restoring the set point', 2),
  (d_id, 'How is body temperature regulated?', 'Hot: sweat glands active, blood vessels dilate. Cold: shivering, blood vessels constrict.', 3),
  (d_id, 'What is the role of the kidneys in homeostasis?', 'Filter blood, remove urea, control water and ion levels, maintain blood pH', 4),
  (d_id, 'What is an ecosystem?', 'The interaction of a community of living organisms with their non-living environment', 5),
  (d_id, 'What is a food web?', 'A network of interconnected food chains showing the complex feeding relationships in an ecosystem', 6),
  (d_id, 'What is an abiotic factor?', 'Non-living factors: temperature, rainfall, sunlight, wind, soil pH, CO₂ levels', 7),
  (d_id, 'What is a biotic factor?', 'Living factors: competition, predation, disease, human activity', 8),
  (d_id, 'What is the carbon cycle?', 'Carbon moves between atmosphere (CO₂), living organisms, oceans, and fossil fuels', 9),
  (d_id, 'What is decomposition?', 'The breakdown of dead organisms by detritivores and saprophytes, recycling nutrients', 10),
  (d_id, 'What factors affect the rate of decomposition?', 'Temperature, water, oxygen availability, number of decomposers', 11),
  (d_id, 'What is natural selection?', 'Organisms with favourable mutations survive and reproduce more, passing on those traits', 12),
  (d_id, 'What is genetic engineering?', 'Modifying the DNA of an organism to give it new characteristics (e.g. GM crops, insulin production)', 13),
  (d_id, 'What is selective breeding?', 'Choosing organisms with desired traits to breed together over many generations', 14),
  (d_id, 'What are the risks of selective breeding?', 'Reduced gene pool, inbreeding, inherited disorders, reduced disease resistance', 15),
  (d_id, 'What is the difference between sexual and asexual reproduction?', 'Sexual: two parents, genetic variation. Asexual: one parent, identical offspring, no variation.', 16),
  (d_id, 'What causes genetic variation?', 'Mutations, sexual reproduction (meiosis and random fertilisation)', 17),
  (d_id, 'What is evolution?', 'The gradual change in the characteristics of a population over many generations', 18),
  (d_id, 'Who proposed the theory of evolution by natural selection?', 'Charles Darwin (1859, On the Origin of Species)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Chemistry Year 11 - Rates, Equilibrium & Electrolysis', 'Rates of reaction, equilibrium, electrolysis, organic chemistry', 'Chemistry', 11, 20, 57, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What factors affect the rate of reaction?', 'Temperature, concentration, surface area, catalysts', 0),
  (d_id, 'Why does increasing temperature increase rate?', 'Particles have more kinetic energy, move faster, collide more often and with more energy', 1),
  (d_id, 'What is a catalyst?', 'A substance that speeds up a reaction without being permanently changed', 2),
  (d_id, 'What is activation energy?', 'The minimum energy needed for a reaction to occur', 3),
  (d_id, 'What is the rate of reaction equation?', 'Rate = amount of product formed ÷ time (or amount of reactant used ÷ time)', 4),
  (d_id, 'What is a reversible reaction?', 'A reaction where products can react to reform the original reactants (e.g. A + B ⇌ C + D)', 5),
  (d_id, 'What is dynamic equilibrium?', 'When the forward and reverse reactions occur at equal rates, so concentrations remain constant', 6),
  (d_id, 'What does Le Chatelier principle state?', 'If a change is made to a system at equilibrium, the system adjusts to counteract the change', 7),
  (d_id, 'What is electrolysis?', 'Using an electric current to decompose an ionic compound (molten or in solution)', 8),
  (d_id, 'What happens at the cathode during electrolysis?', 'Positive ions gain electrons (reduction) - metal or hydrogen is produced', 9),
  (d_id, 'What happens at the anode during electrolysis?', 'Negative ions lose electrons (oxidation) - oxygen or halogen is produced', 10),
  (d_id, 'What is the electrolysis of brine (NaCl solution)?', 'Cathode: hydrogen. Anode: chlorine. Solution: sodium hydroxide (NaOH).', 11),
  (d_id, 'What is crude oil?', 'A mixture of hydrocarbons formed from ancient marine organisms under heat and pressure', 12),
  (d_id, 'What is fractional distillation?', 'Separating crude oil into fractions based on boiling points', 13),
  (d_id, 'What are alkanes?', 'Saturated hydrocarbons with only single bonds (CₙH₂ₙ₊₂)', 14),
  (d_id, 'What are alkenes?', 'Unsaturated hydrocarbons with at least one C=C double bond', 15),
  (d_id, 'What is the test for an unsaturated hydrocarbon?', 'Bromine water turns from orange/brown to colourless', 16),
  (d_id, 'What is combustion?', 'Burning a fuel in oxygen - complete combustion produces CO₂ and H₂O', 17),
  (d_id, 'What is incomplete combustion?', 'Burning with limited oxygen - produces carbon monoxide (toxic) and/or carbon (soot)', 18),
  (d_id, 'What is the pH scale for acids and alkalis?', 'Acids: 0-6, Neutral: 7, Alkalis: 8-14', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Physics Year 11 - Magnetism, Electromagnetism & Nuclear', 'Magnetism, electromagnetism, and nuclear physics', 'Physics', 11, 20, 52, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a magnetic field?', 'The region around a magnet where a magnetic force acts on other magnets or magnetic materials', 0),
  (d_id, 'What are the poles of a magnet?', 'North and South - like poles repel, unlike poles attract', 1),
  (d_id, 'What materials are magnetic?', 'Iron, nickel, cobalt, and some alloys (steel)', 2),
  (d_id, 'How do you draw magnetic field lines?', 'From North to South outside the magnet, in continuous loops, closer together where the field is stronger', 3),
  (d_id, 'What is an electromagnet?', 'A coil of wire with an electric current flowing through it, producing a magnetic field', 4),
  (d_id, 'How do you make an electromagnet stronger?', 'Increase current, more coils, add an iron core', 5),
  (d_id, 'What is the motor effect?', 'A current-carrying conductor in a magnetic field experiences a force (F = BIL)', 6),
  (d_id, 'What is Flemings Left Hand Rule?', 'Thumb = motion, First finger = field (N to S), Second finger = current. Used for motors.', 7),
  (d_id, 'What is electromagnetic induction?', 'Moving a conductor through a magnetic field induces a voltage (and current in a complete circuit)', 8),
  (d_id, 'What is Flemings Right Hand Rule?', 'Thumb = motion, First finger = field, Second finger = current. Used for generators.', 9),
  (d_id, 'What is the difference between a motor and a generator?', 'Motor: electrical energy to mechanical energy. Generator: mechanical energy to electrical energy.', 10),
  (d_id, 'What is nuclear fission?', 'The splitting of a heavy nucleus into two lighter nuclei, releasing energy', 11),
  (d_id, 'What is nuclear fusion?', 'The joining of two light nuclei to form a heavier nucleus, releasing energy', 12),
  (d_id, 'What is nuclear radiation?', 'The emission of particles or electromagnetic waves from an unstable nucleus (alpha, beta, gamma)', 13),
  (d_id, 'What is alpha radiation?', 'Helium nuclei (2 protons + 2 neutrons) - stopped by paper, least penetrating', 14),
  (d_id, 'What is beta radiation?', 'High-speed electrons - stopped by thin aluminium, moderately penetrating', 15),
  (d_id, 'What is gamma radiation?', 'Electromagnetic waves - most penetrating, stopped by thick lead', 16),
  (d_id, 'What is half-life?', 'The time taken for half of the radioactive atoms in a sample to decay', 17),
  (d_id, 'What are the uses of nuclear radiation?', 'Medical (X-rays, cancer treatment), energy (nuclear power), smoke detectors, sterilisation', 18),
  (d_id, 'What is background radiation?', 'Low-level radiation from natural sources (rocks, cosmic rays) and man-made sources', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE English Lit Year 11 - An Inspector Calls & Poetry', 'An Inspector Calls revision, poetry anthology', 'English', 11, 20, 63, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who is the Inspector?', 'Inspector Goole - possibly supernatural, representing moral conscience and social responsibility', 0),
  (d_id, 'What did each character do to Eva Smith?', 'Birling: fired her. Sheila: got her sacked from a shop. Gerald: kept her as mistress. Eric: got her pregnant. Mrs Birling: refused her charity.', 1),
  (d_id, '"We are members of one body" - who says this?', 'The Inspector, in his final speech about social responsibility', 2),
  (d_id, 'What is the significance of the time setting (1912)?', 'Written in 1945 but set in 1912 - Priestley shows the audience that attitudes of 1912 led to two World Wars', 3),
  (d_id, 'What is the structure of the play?', 'Unity of time and place - real time, one setting, building tension to the Inspectors exit, then reversal', 4),
  (d_id, 'What does the Inspector represent?', 'Social conscience, the voice of Priestley, a symbol of moral authority', 5),
  (d_id, 'What is Mr Birlings advice to Sheila?', '"A man has to mind his own business and look after himself and his own" - capitalist, selfish attitude', 6),
  (d_id, 'What is the significance of the circular structure?', 'The ending returns to the beginning - suggests the cycle of responsibility will repeat', 7),
  (d_id, 'Name 3 techniques for poetry analysis', 'Simile, metaphor, personification, imagery, alliteration, sibilance, enjambment, assonance', 8),
  (d_id, 'What is the structure of a poetry essay?', 'Intro → Paragraph per poem (quote, technique, effect, comparison) → conclusion', 9),
  (d_id, 'What is an anthology poem?', 'A poem included in the AQA/Edexcel/Pearson poetry anthology studied for the exam', 10),
  (d_id, 'What is the key message of exposure by Owen?', 'The real enemy of soldiers is not the Germans but the cold and nature', 11),
  (d_id, 'What is the key message of remains by Armitage?', 'The psychological trauma of killing in war - the image of the dead body haunts the speaker', 12),
  (d_id, 'What is the key message of war photographer by Duffy?', 'The contrast between suffering in war zones and indifference at home', 13),
  (d_id, 'What is the key message of bayonet charge by Berry?', 'The chaotic, dehumanising reality of war vs the propaganda image of glory', 14),
  (d_id, 'How do you compare two poems?', 'Look at: theme, tone, language, structure, and the poets attitudes - use comparative connectives', 15),
  (d_id, 'What is an unseen poetry essay?', 'An exam question on a poem you havent studied - analyse language, structure, and meaning', 16),
  (d_id, 'What is the difference between language and structure analysis?', 'Language: word choice, imagery, figurative language. Structure: form, rhythm, line breaks, enjambment.', 17),
  (d_id, 'What is a contextual point?', 'Linking the poem/play to the historical, social, or biographical context of the writer', 18),
  (d_id, 'What is Priestleys purpose in writing An Inspector Calls?', 'To warn audiences about the dangers of selfish capitalism and promote socialist values of collective responsibility', 19);

  -- =============================================
  -- YEAR 12 (A-Level Year 1)
  -- =============================================

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Maths Year 12 - Pure Maths', 'Differentiation, integration, logarithms, binomial expansion', 'Mathematics', 12, 20, 75, 5)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is differentiation from first principles?', 'f(x) = lim(h→0) [f(x+h) - f(x)] / h', 0),
  (d_id, 'What is the derivative of xⁿ?', 'nxⁿ⁻¹ (power rule)', 1),
  (d_id, 'What is the derivative of eˣ?', 'eˣ', 2),
  (d_id, 'What is the derivative of ln(x)?', '1/x', 3),
  (d_id, 'What is the derivative of sin(x)?', 'cos(x)', 4),
  (d_id, 'What is the derivative of cos(x)?', '-sin(x)', 5),
  (d_id, 'What is the chain rule?', 'If y = f(g(x)), then dy/dx = f(g(x)) × g(x)', 6),
  (d_id, 'What is the product rule?', 'If y = uv, then dy/dx = u(dv/dx) + v(du/dx)', 7),
  (d_id, 'What is the quotient rule?', 'If y = u/v, then dy/dx = (v(du/dx) - u(dv/dx)) / v²', 8),
  (d_id, 'What is integration?', 'The reverse of differentiation. The integral of xⁿ is xⁿ⁺¹/(n+1) + C', 9),
  (d_id, 'What is the integral of 1/x?', 'ln|x| + C', 10),
  (d_id, 'What is the integral of eˣ?', 'eˣ + C', 11),
  (d_id, 'What is a logarithm?', 'log₂(8) = 3 means 2³ = 8. Logs are the inverse of exponentials.', 12),
  (d_id, 'What are the log laws?', 'log(ab) = log(a) + log(b), log(a/b) = log(a) - log(b), log(aⁿ) = n·log(a)', 13),
  (d_id, 'What is the change of base formula?', 'logₐ(b) = ln(b)/ln(a)', 14),
  (d_id, 'What is the binomial expansion?', '(1+x)ⁿ = 1 + nx + n(n-1)x²/2! + ... for any real n', 15),
  (d_id, 'What is the binomial coefficient nCr?', 'nCr = n! / (r!(n-r)!) - the coefficient of xʳ in the expansion of (1+x)ⁿ', 16),
  (d_id, 'What is a stationary point?', 'Where dy/dx = 0. Could be a maximum, minimum, or point of inflection.', 17),
  (d_id, 'How do you distinguish max from min?', 'Second derivative test: f(x) < 0 = maximum, f(x) > 0 = minimum', 18),
  (d_id, 'What is the fundamental theorem of calculus?', 'Integral from a to b of f(x)dx = F(b) - F(a)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Biology Year 12 - Biological Molecules & Cells', 'Biological molecules, cell structure, transport', 'Biology', 12, 20, 68, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the four main biological molecules?', 'Carbohydrates, lipids, proteins, nucleic acids', 0),
  (d_id, 'What is the monomer of a carbohydrate?', 'Monosaccharides (simple sugars like glucose, fructose)', 1),
  (d_id, 'What is the difference between starch and glycogen?', 'Starch (plants): energy storage. Glycogen (animals): branched, stored in liver and muscles.', 2),
  (d_id, 'What is the structure of a triglyceride?', 'One glycerol + three fatty acids, linked by ester bonds', 3),
  (d_id, 'What are the four levels of protein structure?', 'Primary (amino acid sequence), Secondary (alpha helix/beta sheet), Tertiary (3D folding), Quaternary (multiple polypeptides)', 4),
  (d_id, 'What is an enzyme?', 'A globular protein that acts as a biological catalyst', 5),
  (d_id, 'What is the induced fit model?', 'The substrate binds to the active site, causing the enzyme to change shape for a better fit', 6),
  (d_id, 'What is the structure of DNA?', 'Double helix - two polynucleotide strands joined by hydrogen bonds between complementary base pairs', 7),
  (d_id, 'What are the base pairing rules?', 'Adenine pairs with Thymine (A-T), Guanine pairs with Cytosine (G-C)', 8),
  (d_id, 'What is semi-conservative replication?', 'Each new DNA molecule contains one original strand and one new strand', 9),
  (d_id, 'What is the role of mRNA in transcription?', 'mRNA is complementary to the DNA template strand and carries the code to the ribosome', 10),
  (d_id, 'What is the role of tRNA in translation?', 'tRNA carries amino acids to the ribosome, matching its anticodon to the mRNA codon', 11),
  (d_id, 'What is the fluid mosaic model?', 'The cell membrane is a phospholipid bilayer with embedded proteins that can move', 12),
  (d_id, 'What is the difference between endocytosis and exocytosis?', 'Endocytosis: material enters the cell in a vesicle. Exocytosis: material leaves the cell.', 13),
  (d_id, 'What is the difference between mitosis and meiosis?', 'Mitosis: 2 identical diploid cells. Meiosis: 4 genetically different haploid cells.', 14),
  (d_id, 'What is the importance of mitosis?', 'Growth, repair, asexual reproduction, replacement of cells', 15),
  (d_id, 'What is the importance of meiosis?', 'Produces genetic variation for sexual reproduction', 16),
  (d_id, 'What is the significance of genetic variation?', 'Enables natural selection and adaptation to changing environments', 17),
  (d_id, 'What are the parts of the digestive system in order?', 'Mouth → oesophagus → stomach → small intestine → large intestine → rectum', 18),
  (d_id, 'What is the difference between mass transport in plants and animals?', 'Plants: xylem (water) and phloem (sugars). Animals: circulatory system with a pump (heart).', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Chemistry Year 12 - Moles, Energetics & Bonding', 'Moles, energetics, periodicity, and bonding', 'Chemistry', 12, 20, 64, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'How do you calculate moles from mass?', 'n = m/M (moles = mass ÷ molar mass)', 0),
  (d_id, 'How do you calculate moles from gas volume?', 'n = V/24 (at room temperature and pressure, 1 mol = 24 dm³)', 1),
  (d_id, 'How do you calculate moles from concentration?', 'n = c × V (moles = concentration × volume in dm³)', 2),
  (d_id, 'What is Avogadros constant?', '6.022 × 10²³ mol⁻¹ - the number of particles in one mole', 3),
  (d_id, 'What is the ideal gas equation?', 'pV = nRT (pressure × volume = moles × gas constant × temperature in Kelvin)', 4),
  (d_id, 'What is enthalpy change (ΔH)?', 'The heat energy change at constant pressure during a reaction', 5),
  (d_id, 'What is an exothermic reaction?', 'ΔH is negative - energy is released to the surroundings (gets warmer)', 6),
  (d_id, 'What is an endothermic reaction?', 'ΔH is positive - energy is absorbed from the surroundings (gets cooler)', 7),
  (d_id, 'What is Hess law?', 'The total enthalpy change is independent of the route taken (only depends on initial and final states)', 8),
  (d_id, 'How do you calculate enthalpy change from bond energies?', 'ΔH = Total energy of bonds broken - Total energy of bonds formed', 9),
  (d_id, 'What is the enthalpy of formation?', 'The enthalpy change when 1 mole of a compound is formed from its elements in their standard states', 10),
  (d_id, 'What is the enthalpy of combustion?', 'The enthalpy change when 1 mole of a substance is completely burned in oxygen', 11),
  (d_id, 'What is aBorn-Haber cycle?', 'An energy cycle diagram showing the steps involved in forming an ionic compound', 12),
  (d_id, 'What is lattice energy?', 'The energy released when gaseous ions form 1 mole of an ionic solid', 13),
  (d_id, 'What is the trend in atomic radius across a period?', 'Decreases (more protons pull electrons closer to the nucleus)', 14),
  (d_id, 'What is the trend in first ionisation energy across a period?', 'Generally increases (more protons, smaller radius, harder to remove electron)', 15),
  (d_id, 'What are the exceptions in IE trend?', 'Group 2→3 (lower due to p-subshell), Group 5→6 (lower due to paired electrons repelling)', 16),
  (d_id, 'What is an oxonium ion?', 'H₃O⁺ - a water molecule with an extra H⁺ (hydrogen ion)', 17),
  (d_id, 'What is the difference between strong and weak acids?', 'Strong acids fully ionise in water. Weak acids partially ionise (reversible reaction).', 18),
  (d_id, 'What is a dative covalent bond?', 'A covalent bond where both electrons come from the same atom (e.g. NH₄⁺, H₃O⁺)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Physics Year 12 - Measurements, Mechanics & Materials', 'Measurements, mechanics, and materials', 'Physics', 12, 20, 59, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are SI base units?', 'kg, m, s, A, K, mol, cd', 0),
  (d_id, 'What is the difference between accuracy and precision?', 'Accuracy: closeness to true value. Precision: closeness of repeated measurements to each other.', 1),
  (d_id, 'What is systematic error?', 'A consistent error that affects all readings in the same way (e.g. zero error)', 2),
  (d_id, 'What is random error?', 'Unpredictable variations in readings that can be reduced by repeating and averaging', 3),
  (d_id, 'What is absolute, fractional, and percentage uncertainty?', 'Absolute: ± value. Fractional: absolute/measured. Percentage: fractional × 100.', 4),
  (d_id, 'What is the SUVAT equation v = u + at?', 'Final velocity = initial velocity + (acceleration × time)', 5),
  (d_id, 'What is the SUVAT equation s = ut + ½at²?', 'Displacement = initial velocity × time + ½ × acceleration × time²', 6),
  (d_id, 'What is the SUVAT equation v² = u² + 2as?', 'Final velocity² = initial velocity² + 2 × acceleration × displacement', 7),
  (d_id, 'What is Newton Second Law?', 'F = ma (Net force equals mass times acceleration)', 8),
  (d_id, 'What is the difference between mass and weight?', 'Mass: amount of matter (kg, scalar). Weight: gravitational force (N, vector).', 9),
  (d_id, 'What is Newton Third Law?', 'For every action force, there is an equal and opposite reaction force on a different object', 10),
  (d_id, 'What is the difference between scalar and vector?', 'Scalar: magnitude only (speed, mass, energy). Vector: magnitude and direction (velocity, force, displacement).', 11),
  (d_id, 'What is Hooke law?', 'F = kx (Force = spring constant × extension, within elastic limit)', 12),
  (d_id, 'What is the Young modulus?', 'E = stress/strain = (F/A) / (extension/original length)', 13),
  (d_id, 'What is stress?', 'Stress = Force / Cross-sectional area (Pa)', 14),
  (d_id, 'What is strain?', 'Strain = Extension / Original length (no units)', 15),
  (d_id, 'What is the area under a force-extension graph?', 'The energy stored (work done) in stretching', 16),
  (d_id, 'What is the elastic limit?', 'The point beyond which the material does not return to its original shape (permanent deformation)', 17),
  (d_id, 'What is ductile material?', 'A material that can be stretched into a wire (e.g. copper, aluminium)', 18),
  (d_id, 'What is brittle material?', 'A material that breaks with little or no deformation (e.g. glass, cast iron)', 19);

  -- =============================================
  -- YEAR 13 (A-Level Year 2 - Exam Year)
  -- =============================================

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Maths Year 13 - Further Calculus & Vectors', 'Further calculus, differential equations, vectors', 'Mathematics', 13, 20, 72, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is integration by parts?', '∫u(dv/dx)dx = uv - ∫v(du/dx)dx. Choose u and dv/dx using LIATE rule.', 0),
  (d_id, 'What is integration by substitution?', 'Let u = g(x), then du/dx = g(x), and substitute into the integral', 1),
  (d_id, 'What is the integral of sec²(x)?', 'tan(x) + C', 2),
  (d_id, 'What is the integral of tan(x)?', 'ln|sec(x)| + C or -ln|cos(x)| + C', 3),
  (d_id, 'What is the integral of sec(x)?', 'ln|sec(x) + tan(x)| + C', 4),
  (d_id, 'What is partial fractions?', 'Splitting a complex fraction into simpler fractions for easier integration', 5),
  (d_id, 'What is a differential equation?', 'An equation involving derivatives (e.g. dy/dx = f(x,y))', 6),
  (d_id, 'What is the trapezium rule?', 'Area ≈ ½h[y₀ + 2(y₁ + y₂ + ... + yₙ₋₁) + yₙ]', 7),
  (d_id, 'What is implicit differentiation?', 'Differentiating both sides of an equation with respect to x, treating y as a function of x', 8),
  (d_id, 'What is parametric differentiation?', 'Finding dy/dx when x and y are both given as functions of t: dy/dx = (dy/dt)/(dx/dt)', 9),
  (d_id, 'What is a position vector?', 'A vector from the origin to a point: r = xi + yj + zk', 10),
  (d_id, 'What is the magnitude of a 3D vector?', '|r| = √(x² + y² + z²)', 11),
  (d_id, 'What is the dot product?', 'a · b = |a||b|cos(θ) = a₁b₁ + a₂b₂ + a₃b₃', 12),
  (d_id, 'What does a · b = 0 mean?', 'The vectors are perpendicular (at right angles)', 13),
  (d_id, 'What is the vector equation of a line?', 'r = a + λb (where a is a point on the line and b is the direction vector)', 14),
  (d_id, 'What is the angle between two planes?', 'The angle between their normal vectors', 15),
  (d_id, 'What is the cross product?', 'a × b = |a||b|sin(θ) û, gives a vector perpendicular to both a and b', 16),
  (d_id, 'What is the area of a triangle using vectors?', 'Area = ½|a × b|', 17),
  (d_id, 'What is Maclaurin series?', 'A Taylor series centered at x=0: f(x) = f(0) + f(0)x + f(0)x²/2! + ...', 18),
  (d_id, 'What is the Maclaurin series for eˣ?', 'eˣ = 1 + x + x²/2! + x³/3! + ...', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Biology Year 13 - Gene Expression & Ecosystems', 'Gene expression, ecosystems, and evolution', 'Biology', 13, 20, 66, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a genome?', 'The entire set of genetic information in an organism', 0),
  (d_id, 'What is gene expression?', 'The process by which information from a gene is used to produce a functional product (protein)', 1),
  (d_id, 'What is the lac operon?', 'A gene regulation system in bacteria where genes for lactose metabolism are only expressed when lactose is present', 2),
  (d_id, 'What is epigenetics?', 'Changes in gene expression that do not involve changes to the DNA sequence', 3),
  (d_id, 'What is methylation in gene regulation?', 'Adding methyl groups to DNA to switch genes off', 4),
  (d_id, 'What is a restriction enzyme?', 'An enzyme that cuts DNA at specific recognition sequences', 5),
  (d_id, 'What is gel electrophoresis?', 'A technique to separate DNA fragments by size using an electric field', 6),
  (d_id, 'What is PCR?', 'Polymerase Chain Reaction - technique to rapidly amplify (copy) specific DNA sequences', 7),
  (d_id, 'What is DNA profiling?', 'Comparing individuals based on unique patterns in their DNA', 8),
  (d_id, 'What is gene therapy?', 'Treating genetic disorders by introducing functional genes into cells', 9),
  (d_id, 'What is the Hardy-Weinberg principle?', 'In a large, randomly mating population with no selection, allele and genotype frequencies remain constant', 10),
  (d_id, 'What is the equation p + q = 1?', 'p = frequency of dominant allele, q = frequency of recessive allele', 11),
  (d_id, 'What is the equation p² + 2pq + q² = 1?', 'p² = homozygous dominant frequency, 2pq = heterozygous frequency, q² = homozygous recessive frequency', 12),
  (d_id, 'What is natural selection?', 'Individuals with advantageous alleles are more likely to survive and reproduce, increasing allele frequency', 13),
  (d_id, 'What is speciation?', 'The formation of new species when populations become reproductively isolated', 14),
  (d_id, 'What is the difference between directional and stabilising selection?', 'Directional: favours one extreme. Stabilising: favours the middle/average phenotype.', 15),
  (d_id, 'What is biodiversity?', 'The variety of living organisms in an area - species, genetic, and ecosystem diversity', 16),
  (d_id, 'What is a keystone species?', 'A species that has a disproportionately large effect on its ecosystem', 17),
  (d_id, 'What is succession?', 'The gradual change of species in an ecosystem over time (primary and secondary)', 18),
  (d_id, 'What is the carbon cycle?', 'Carbon moves between atmosphere, organisms, oceans, and fossil fuels through photosynthesis, respiration, decomposition, and combustion', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Chemistry Year 13 - Kinetics, Thermochemistry & Electrochemistry', 'Kinetics, thermodynamics, and electrochemistry', 'Chemistry', 13, 20, 61, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the rate equation?', 'Rate = k[A]ᵐ[B]ⁿ (k = rate constant, m and n = orders of reaction)', 0),
  (d_id, 'What is a first order reaction?', 'Rate is proportional to the concentration of one reactant (Rate = k[A])', 1),
  (d_id, 'What is a second order reaction?', 'Rate is proportional to the square of a concentration (Rate = k[A]²)', 2),
  (d_id, 'What is the half-life of a first order reaction?', 'Constant - does not change with concentration', 3),
  (d_id, 'How do you find the rate constant from a graph?', 'For first order: plot ln[A] vs time, gradient = -k', 4),
  (d_id, 'What is the Arrhenius equation?', 'k = Ae^(-Ea/RT) - relates rate constant to temperature and activation energy', 5),
  (d_id, 'What does a catalyst do to activation energy?', 'Provides an alternative reaction pathway with a lower activation energy', 6),
  (d_id, 'What is entropy (ΔS)?', 'A measure of the disorder or randomness of a system', 7),
  (d_id, 'What is Gibbs free energy?', 'ΔG = ΔH - TΔS. If ΔG < 0, the reaction is spontaneous.', 8),
  (d_id, 'What is dynamic equilibrium?', 'Forward and reverse reactions occur at equal rates; concentrations are constant', 9),
  (d_id, 'What is the equilibrium constant Kc?', 'Kc = [products] / [reactants] (raised to their stoichiometric coefficients)', 10),
  (d_id, 'What does a large Kc mean?', 'The equilibrium lies far to the right (products favoured)', 11),
  (d_id, 'What is the relationship between Kp and Kc?', 'Kp = Kc(RT)^Δn (Δn = change in moles of gas)', 12),
  (d_id, 'What is an electrochemical cell?', 'A device that converts chemical energy into electrical energy through redox reactions', 13),
  (d_id, 'What is a standard electrode potential?', 'The voltage of a half-cell under standard conditions (298K, 1 atm, 1 mol/dm³)', 14),
  (d_id, 'What is the electrode with the more negative E°?', 'It is the stronger reducing agent (more likely to be oxidised)', 15),
  (d_id, 'What is electrolysis used for industrially?', 'Extraction of aluminium (from bauxite), purification of copper, chlor-alkali process', 16),
  (d_id, 'What is the Nernst equation?', 'Relates electrode potential to concentration: E = E° - (RT/nF)ln(Q)', 17),
  (d_id, 'What is an enantiomer?', 'One of a pair of non-superimposable mirror image molecules (chiral)', 18),
  (d_id, 'What is optical isomerism?', 'A type of stereoisomerism where molecules rotate plane-polarised light in different directions', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Physics Year 13 - Circular Motion, Gravitation & Thermo', 'Circular motion, gravitation, and thermodynamics', 'Physics', 13, 20, 58, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is angular velocity?', 'ω = 2πf = 2π/T (radians per second)', 0),
  (d_id, 'What is centripetal acceleration?', 'a = v²/r = ω²r (directed towards the centre of the circle)', 1),
  (d_id, 'What is centripetal force?', 'F = mv²/r = mω²r (the net force keeping an object in circular motion)', 2),
  (d_id, 'What is a geostationary orbit?', 'An orbit above the equator where the satellite has a period of 24 hours and stays above the same point', 3),
  (d_id, 'What is Newton law of gravitation?', 'F = GMm/r² (force between two masses is proportional to product of masses and inversely proportional to distance squared)', 4),
  (d_id, 'What is the gravitational field strength?', 'g = GM/r² (force per unit mass at a distance r from the centre of a mass M)', 5),
  (d_id, 'What is gravitational potential?', 'V = -GM/r (the work done per unit mass to bring a mass from infinity to that point)', 6),
  (d_id, 'What is escape velocity?', 'v = √(2GM/R) - the minimum speed needed to escape a gravitational field', 7),
  (d_id, 'What is the first law of thermodynamics?', 'ΔU = Q - W (change in internal energy = heat supplied - work done)', 8),
  (d_id, 'What is an ideal gas?', 'A gas that obeys pV = nRT - no intermolecular forces, negligible volume', 9),
  (d_id, 'What is the kinetic theory of gases?', 'Gas pressure is caused by molecules colliding with container walls', 10),
  (d_id, 'What is absolute zero?', '0 Kelvin (-273.15°C) - the temperature at which particles have minimum kinetic energy', 11),
  (d_id, 'What is the internal energy of a gas?', 'The sum of kinetic energies of all the molecules (related to temperature)', 12),
  (d_id, 'What is the difference between isothermal and adiabatic?', 'Isothermal: constant temperature (ΔU = 0, Q = W). Adiabatic: no heat transfer (Q = 0, ΔU = -W).', 13),
  (d_id, 'What is the work done in an isothermal process?', 'W = nRT ln(V₂/V₁)', 14),
  (d_id, 'What is simple harmonic motion (SHM)?', 'Motion where acceleration is proportional to displacement and directed towards equilibrium: a = -ω²x', 15),
  (d_id, 'What is the period of a mass-spring system?', 'T = 2π√(m/k)', 16),
  (d_id, 'What is the period of a simple pendulum?', 'T = 2π√(L/g) (only for small angles)', 17),
  (d_id, 'What is resonance?', 'When the driving frequency equals the natural frequency, resulting in maximum amplitude', 18),
  (d_id, 'What is the Doppler effect for light?', 'A shift in frequency/wavelength due to relative motion between source and observer (blueshift = approaching, redshift = receding)', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Psychology Year 12 - Approaches, Memory & Attachment', 'Psychological approaches, memory, and attachment', 'Psychology', 12, 20, 55, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the behaviourist approach?', 'Focuses on observable behaviour and learning through conditioning (Pavlov, Skinner, Watson)', 0),
  (d_id, 'What is the cognitive approach?', 'Focuses on mental processes: memory, perception, thinking, problem-solving', 1),
  (d_id, 'What is the biological approach?', 'Focuses on genetics, brain structures, neurotransmitters, and evolution', 2),
  (d_id, 'What is the psychodynamic approach?', 'Freud: unconscious mind, childhood experiences, ID/ego/superego', 3),
  (d_id, 'What is the humanistic approach?', 'Focuses on free will, self-actualisation, and personal growth (Rogers, Maslow)', 4),
  (d_id, 'What is the social learning theory?', 'People learn through observation, imitation, and modelling (Bandura)', 5),
  (d_id, 'What is the multi-store model of memory?', 'Atkinson & Shiffrin: sensory register → STM → LTM (with rehearsal)', 6),
  (d_id, 'What is the difference between STM and LTM?', 'STM: limited capacity (7±2), duration (18-30s). LTM: unlimited capacity, potentially permanent.', 7),
  (d_id, 'What is the Working Memory Model?', 'Baddeley: central executive, phonological loop, visuospatial sketchpad, episodic buffer', 8),
  (d_id, 'What is the types of LTM?', 'Episodic (events), Semantic (facts), Procedural (skills)', 9),
  (d_id, 'What is the cognitive interview?', 'A technique for witnesses: reinstate context, report everything, reverse order, change perspective', 10),
  (d_id, 'What is encoding failure?', 'Information never enters LTM because it was not attended to', 11),
  (d_id, 'What is proactive interference?', 'Old memories interfere with new memories (e.g. forgetting your new password because of the old one)', 12),
  (d_id, 'What is retroactive interference?', 'New memories interfere with old memories', 13),
  (d_id, 'What is the concept of attachment?', 'A deep emotional bond between two individuals, especially between infant and caregiver', 14),
  (d_id, 'What is Harlows experiment with monkeys?', 'Monkeys preferred a soft cloth mother over a wire mother with food, showing comfort > feeding for attachment', 15),
  (d_id, 'What is the internal working model?', 'Bowlbys idea that early attachment creates a mental template for future relationships', 16),
  (d_id, 'What is Ainsworth Strange Situation?', 'A procedure to classify attachment: Secure (B), Insecure-avoidant (A), Insecure-resistant (C), Disorganised (D)', 17),
  (d_id, 'What is monotropy?', 'Bowlbys idea that infants form a primary attachment to one main caregiver', 18),
  (d_id, 'What is the critical period for attachment?', 'The first 2.5 years - if no attachment forms by then, social/emotional difficulties may follow', 19);

  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Psychology Year 13 - Schizophrenia & Research Methods', 'Schizophrenia, issues, and research methods', 'Psychology', 13, 20, 53, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is schizophrenia?', 'A severe mental disorder characterised by delusions, hallucinations, and disordered thinking', 0),
  (d_id, 'What are positive symptoms of schizophrenia?', 'Symptoms added to experience: hallucinations, delusions, disorganised speech/behaviour', 1),
  (d_id, 'What are negative symptoms of schizophrenia?', 'Symptoms removed from experience: flat affect, avolition, alogia, anhedonia', 2),
  (d_id, 'What is the dopamine hypothesis?', 'Schizophrenia is caused by excess dopamine activity in the brain', 3),
  (d_id, 'How do antipsychotic drugs work?', 'They block D2 dopamine receptors, reducing dopamine activity', 4),
  (d_id, 'What is the family dysfunction explanation?', 'Abnormal family communication (double bind, expressed emotion) contributes to schizophrenia', 5),
  (d_id, 'What is a double bind?', 'A situation where a child receives contradictory messages from a parent (e.g. wanting a hug but being pushed away)', 6),
  (d_id, 'What is expressed emotion (EE)?', 'High levels of criticism, hostility, or emotional over-involvement from family members', 7),
  (d_id, 'What is CBT for psychosis?', 'Cognitive behavioural therapy adapted to help patients question and manage delusional beliefs', 8),
  (d_id, 'What is a hypothesis?', 'A testable prediction about the outcome of a study', 9),
  (d_id, 'What is the difference between independent and dependent variables?', 'IV: what the researcher manipulates. DV: what is measured.', 10),
  (d_id, 'What is an experiment?', 'A study where the IV is manipulated and the DV is measured, with controls for extraneous variables', 11),
  (d_id, 'What is a correlation?', 'A study examining the relationship between two variables without manipulation', 12),
  (d_id, 'What is a case study?', 'An in-depth investigation of an individual, group, or organisation', 13),
  (d_id, 'What is a self-report method?', 'Data collection through questionnaires or interviews where participants report their own behaviour/feelings', 14),
  (d_id, 'What is validity?', 'Whether the research measures what it claims to measure', 15),
  (d_id, 'What is reliability?', 'Whether the research produces consistent results', 16),
  (d_id, 'What is ecological validity?', 'Whether findings can be generalised to real-life settings', 17),
  (d_id, 'What are the ethical issues in psychology research?', 'Informed consent, deception, protection from harm, right to withdraw, confidentiality', 18),
  (d_id, 'What is statistical significance?', 'A result is statistically significant if it is unlikely to have occurred by chance (p < 0.05)', 19);

  RAISE NOTICE 'UK Curriculum seed complete! Decks for Years 7-13 inserted.';
END;
$$;

SELECT seed_uk_curriculum();
DROP FUNCTION seed_uk_curriculum();
