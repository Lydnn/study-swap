-- StudySwap Full UK Syllabus Seed
-- Generated: comprehensive decks for KS3, GCSE, and A-Level
-- Run AFTER migration.sql and schema.sql

CREATE OR REPLACE FUNCTION seed_full_syllabus()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  seed_user_id uuid;
  d_id uuid;
BEGIN
  IF EXISTS (SELECT 1 FROM decks WHERE description LIKE 'SYLLABUS:%' LIMIT 1) OR EXISTS (SELECT 1 FROM study_guides WHERE title = 'GCSE Maths Full Syllabus Guide' LIMIT 1) THEN
    RAISE NOTICE 'Full syllabus data already exists, skipping.';
    RETURN;
  END IF;

  SELECT id INTO seed_user_id FROM auth.users LIMIT 1;
  IF seed_user_id IS NULL THEN
    RAISE NOTICE 'No users found. Please create an account first.';
    RETURN;
  END IF;

  -- Year 7 Maths - Number Skills
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Maths - Number Skills', 'SYLLABUS: Place value, negative numbers, fractions, decimals, percentages, factors & multiples', 'Mathematics', 7, 25, 29, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is place value?', 'The value of a digit based on its position in a number (hundreds, tens, units, tenths...)', 0),
  (d_id, 'What is a prime number?', 'A number with exactly two factors: 1 and itself (2, 3, 5, 7, 11)', 1),
  (d_id, 'Is 1 a prime number?', 'No. 1 has only one factor, so it is not prime.', 2),
  (d_id, 'What is a factor?', 'A number that divides exactly into another (factors of 12: 1, 2, 3, 4, 6, 12)', 3),
  (d_id, 'What is a multiple?', 'The result of multiplying a number by an integer (multiples of 4: 4, 8, 12...)', 4),
  (d_id, 'What is the HCF of 12 and 18?', '6. Highest Common Factor of 12 and 18.', 5),
  (d_id, 'What is the LCM of 4 and 6?', '12. Lowest Common Multiple.', 6),
  (d_id, 'What is -5 + 3?', '-2. On a number line, start at -5 and move 3 right.', 7),
  (d_id, 'What is -4 x -3?', '12. Negative x negative = positive.', 8),
  (d_id, 'What is 3/4 as a decimal?', '0.75 (divide 3 by 4).', 9),
  (d_id, 'What is 3/4 as a percentage?', '75%.', 10),
  (d_id, 'How do you add 1/4 + 1/2?', 'Common denominator 4: 1/4 + 2/4 = 3/4.', 11),
  (d_id, 'What is 50% of 260?', '130.', 12),
  (d_id, 'What is 15% of 200?', '30.', 13),
  (d_id, 'What does BODMAS stand for?', 'Brackets, Orders (powers), Division, Multiplication, Addition, Subtraction.', 14),
  (d_id, 'Round 4.276 to 1 decimal place.', '4.3 (look at the second decimal digit: 7 rounds up).', 15),
  (d_id, 'Round 3452 to the nearest hundred.', '3500.', 16),
  (d_id, 'What is 7 squared?', '49.', 17),
  (d_id, 'What is 2 cubed?', '8.', 18),
  (d_id, 'What is the square root of 81?', '9.', 19),
  (d_id, 'Write 0.35 as a fraction in simplest form.', '7/20 (35/100 simplifies by dividing by 5).', 20),
  (d_id, 'What is 1/5 as a percentage?', '20%.', 21),
  (d_id, 'What is 120% of 50?', '60.', 22),
  (d_id, 'Increase 80 by 25%.', '100 (25% of 80 is 20, so 80 + 20).', 23),
  (d_id, 'What is the difference between 3.6 and 0.9?', '2.7.', 24);

  -- Year 7 Maths - Algebra Basics
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Maths - Algebra Basics', 'SYLLABUS: Expressions, simplifying, solving linear equations, substitution', 'Mathematics', 7, 23, 44, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a variable?', 'A letter that represents an unknown number (e.g. x, y).', 0),
  (d_id, 'What is an expression?', 'A combination of terms without an equals sign (e.g. 3x + 5).', 1),
  (d_id, 'Simplify 3x + 2x', '5x.', 2),
  (d_id, 'Simplify 4a + 3b - 2a + b', '2a + 4b (collect like terms).', 3),
  (d_id, 'What does 2x mean?', '2 multiplied by x.', 4),
  (d_id, 'Evaluate 3x + 2 when x = 5.', '17.', 5),
  (d_id, 'Evaluate 4y - 3 when y = 2.', '5.', 6),
  (d_id, 'Solve x + 7 = 15.', 'x = 8 (subtract 7 from both sides).', 7),
  (d_id, 'Solve x - 4 = 9.', 'x = 13.', 8),
  (d_id, 'Solve 3x = 21.', 'x = 7 (divide both sides by 3).', 9),
  (d_id, 'Solve x/2 = 6.', 'x = 12.', 10),
  (d_id, 'What is the coefficient of x in 5x?', '5.', 11),
  (d_id, 'What are like terms?', 'Terms with the same variable (3x and 7x are like terms; 3x and 3y are not).', 12),
  (d_id, 'Simplify 5 x 3x', '15x.', 13),
  (d_id, 'Simplify 2(x + 3).', '2x + 6 (expand the bracket).', 14),
  (d_id, 'What is the term independent of x in 2x + 5?', '5 (the constant term).', 15),
  (d_id, 'Write an expression for ''3 more than a number n''.', 'n + 3.', 16),
  (d_id, 'Write an expression for ''twice a number n''.', '2n.', 17),
  (d_id, 'Simplify 6x - x', '5x.', 18),
  (d_id, 'If a = 2 and b = 3, find a² + b.', '7 (4 + 3).', 19),
  (d_id, 'Solve 2x + 3 = 11.', 'x = 4.', 20),
  (d_id, 'Solve 5x - 2 = 13.', 'x = 3.', 21),
  (d_id, 'What is the difference between an expression and an equation?', 'An equation has an equals sign and can be solved; an expression does not.', 22);

  -- Year 7 Maths - Shapes & Geometry
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Maths - Shapes & Geometry', 'SYLLABUS: Angles, triangles, quadrilaterals, perimeter, area, symmetry', 'Mathematics', 7, 24, 59, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'How many degrees in a straight line?', '180 degrees.', 0),
  (d_id, 'How many degrees around a point?', '360 degrees.', 1),
  (d_id, 'What is an acute angle?', 'An angle less than 90 degrees.', 2),
  (d_id, 'What is an obtuse angle?', 'An angle between 90 and 180 degrees.', 3),
  (d_id, 'What is a right angle?', 'Exactly 90 degrees.', 4),
  (d_id, 'Angles in a triangle add to how many degrees?', '180 degrees.', 5),
  (d_id, 'Angles in a quadrilateral add to how many degrees?', '360 degrees.', 6),
  (d_id, 'What is the area of a rectangle 8cm by 3cm?', '24 cm² (length x width).', 7),
  (d_id, 'What is the perimeter of a square with side 6cm?', '24 cm (4 x 6).', 8),
  (d_id, 'What is the formula for the area of a triangle?', '1/2 x base x height.', 9),
  (d_id, 'What is the area of a triangle with base 10cm and height 4cm?', '20 cm².', 10),
  (d_id, 'What is the circumference of a circle?', 'The distance around the circle (π x diameter).', 11),
  (d_id, 'What is π approximately?', '3.14 or 22/7.', 12),
  (d_id, 'What is the diameter of a circle with radius 5cm?', '10 cm.', 13),
  (d_id, 'What is an isosceles triangle?', 'A triangle with two equal sides and two equal angles.', 14),
  (d_id, 'What is an equilateral triangle?', 'A triangle with all three sides equal; each angle is 60 degrees.', 15),
  (d_id, 'How many lines of symmetry does a square have?', '4.', 16),
  (d_id, 'How many lines of symmetry does a rectangle have?', '2.', 17),
  (d_id, 'What is a regular polygon?', 'A polygon with all sides and all angles equal.', 18),
  (d_id, 'What is the sum of angles in a pentagon?', '540 degrees.', 19),
  (d_id, 'What is a scalene triangle?', 'A triangle with all three sides different.', 20),
  (d_id, 'What is a parallelogram?', 'A quadrilateral with two pairs of parallel sides.', 21),
  (d_id, 'What is the area of a parallelogram?', 'base x height.', 22),
  (d_id, 'What is rotational symmetry?', 'When a shape looks the same after a rotation (order = number of times).', 23);

  -- Year 7 Science - Cells & Organisation
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Science - Cells & Organisation', 'SYLLABUS: Cells, organs, organ systems, movement', 'Science', 7, 23, 58, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the basic unit of life?', 'The cell.', 0),
  (d_id, 'What does the nucleus do?', 'Controls the cell and contains DNA.', 1),
  (d_id, 'What does the cell membrane do?', 'Controls what enters and leaves the cell.', 2),
  (d_id, 'What does the cytoplasm do?', 'Where chemical reactions happen; contains organelles.', 3),
  (d_id, 'What do mitochondria do?', 'Release energy through aerobic respiration.', 4),
  (d_id, 'What do ribosomes do?', 'Make proteins.', 5),
  (d_id, 'What extra parts do plant cells have?', 'Cell wall, chloroplasts, and a permanent vacuole.', 6),
  (d_id, 'What does the cell wall do?', 'Provides support (made of cellulose).', 7),
  (d_id, 'What do chloroplasts do?', 'Absorb light for photosynthesis (contain chlorophyll).', 8),
  (d_id, 'What is a tissue?', 'A group of similar cells working together.', 9),
  (d_id, 'What is an organ?', 'A group of tissues working together (e.g. heart, stomach).', 10),
  (d_id, 'What is an organ system?', 'A group of organs working together (e.g. digestive system).', 11),
  (d_id, 'Name the organ system that breaks down food.', 'The digestive system.', 12),
  (d_id, 'Name the organ system that carries oxygen.', 'The circulatory system.', 13),
  (d_id, 'What is a unicellular organism?', 'An organism made of one cell (e.g. amoeba).', 14),
  (d_id, 'What is a multicellular organism?', 'An organism made of many cells (e.g. humans, plants).', 15),
  (d_id, 'What is a specialised cell?', 'A cell adapted for a particular job (e.g. red blood cell, nerve cell).', 16),
  (d_id, 'Why do red blood cells have no nucleus?', 'To make more room to carry oxygen.', 17),
  (d_id, 'What do nerve cells have that helps transmit signals?', 'Long fibres/dendrites for rapid signalling.', 18),
  (d_id, 'What is the name of the group of tissues working together?', 'An organ.', 19),
  (d_id, 'What is diffusion?', 'The net movement of particles from high to low concentration.', 20),
  (d_id, 'Give an example of diffusion in the body.', 'Oxygen diffusing from alveoli into blood.', 21),
  (d_id, 'What does ''osmosis'' involve?', 'Movement of water across a partially permeable membrane.', 22);

  -- Year 7 Science - Particles & Matter
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Science - Particles & Matter', 'SYLLABUS: States of matter, particle model, changes of state', 'Science', 7, 23, 48, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the three states of matter?', 'Solid, liquid, and gas.', 0),
  (d_id, 'How are particles arranged in a solid?', 'Tightly packed in a regular pattern, vibrating in place.', 1),
  (d_id, 'How are particles arranged in a liquid?', 'Close together but able to move past each other.', 2),
  (d_id, 'How are particles arranged in a gas?', 'Far apart, moving randomly at high speed.', 3),
  (d_id, 'What happens to particles when a solid is heated?', 'They gain energy and vibrate more until it melts.', 4),
  (d_id, 'What is melting?', 'Solid to liquid.', 5),
  (d_id, 'What is freezing?', 'Liquid to solid.', 6),
  (d_id, 'What is evaporation?', 'Liquid to gas at the surface.', 7),
  (d_id, 'What is boiling?', 'Liquid to gas throughout the liquid (at boiling point).', 8),
  (d_id, 'What is condensation?', 'Gas to liquid.', 9),
  (d_id, 'What is sublimation?', 'Solid directly to gas (e.g. dry ice).', 10),
  (d_id, 'Why do substances change state?', 'Because particles gain or lose energy.', 11),
  (d_id, 'What is density?', 'Mass per unit volume (density = mass / volume).', 12),
  (d_id, 'Why does ice float?', 'Ice is less dense than water.', 13),
  (d_id, 'What happens to density when a gas is compressed?', 'Density increases (same mass, smaller volume).', 14),
  (d_id, 'What is diffusion?', 'Spreading out of particles from high to low concentration.', 15),
  (d_id, 'Why does diffusion happen faster in gases than solids?', 'Particles have more energy and more space to move.', 16),
  (d_id, 'What is the boiling point of water?', '100°C at standard pressure.', 17),
  (d_id, 'What is the melting point of pure water?', '0°C.', 18),
  (d_id, 'What is a physical change?', 'A change where no new substance is made (e.g. melting, freezing).', 19),
  (d_id, 'What is a chemical change?', 'A change where a new substance is made (e.g. burning, rusting).', 20),
  (d_id, 'Give an example of a physical change.', 'Melting ice, dissolving sugar, evaporation.', 21),
  (d_id, 'Give an example of a chemical change.', 'Burning wood, rusting iron, cooking an egg.', 22);

  -- Year 7 Science - Forces & Energy
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Science - Forces & Energy', 'SYLLABUS: Forces, balanced/unbalanced, speed, energy stores', 'Science', 7, 22, 29, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a force?', 'A push, pull, or twist acting on an object, measured in newtons (N).', 0),
  (d_id, 'What is the unit of force?', 'The newton (N).', 1),
  (d_id, 'Name three types of force.', 'Gravity, friction, air resistance, magnetic, electrostatic, upthrust (any three).', 2),
  (d_id, 'What is gravity?', 'A force pulling objects towards the centre of a planet.', 3),
  (d_id, 'What is the force of gravity on Earth per kilogram?', 'Approximately 10 N/kg.', 4),
  (d_id, 'What is mass?', 'The amount of matter in an object, measured in kg. Stays the same everywhere.', 5),
  (d_id, 'What is weight?', 'The force of gravity on an object (weight = mass x gravitational field strength).', 6),
  (d_id, 'What is friction?', 'A force that opposes motion between two touching surfaces.', 7),
  (d_id, 'What is air resistance?', 'A type of friction with air particles that slows objects moving through air.', 8),
  (d_id, 'What are balanced forces?', 'Forces that cancel out; the object stays still or moves at constant speed.', 9),
  (d_id, 'What are unbalanced forces?', 'Forces that do not cancel; they change the motion of an object.', 10),
  (d_id, 'What happens to a stationary object with unbalanced forces?', 'It starts to move.', 11),
  (d_id, 'What is speed?', 'Distance travelled per unit time (speed = distance / time).', 12),
  (d_id, 'A car travels 100m in 5s. What is its speed?', '20 m/s.', 13),
  (d_id, 'What is a force meter (spring balance) used for?', 'Measuring forces.', 14),
  (d_id, 'What is upthrust?', 'An upwards force from a fluid that supports objects in it.', 15),
  (d_id, 'Why do objects fall at the same rate in a vacuum?', 'There is no air resistance, only gravity.', 16),
  (d_id, 'Name three energy stores.', 'Kinetic, gravitational potential, elastic, thermal, chemical, nuclear (any three).', 17),
  (d_id, 'What is kinetic energy?', 'The energy of a moving object.', 18),
  (d_id, 'What is gravitational potential energy?', 'Energy stored by an object due to its height.', 19),
  (d_id, 'What is a joule?', 'The unit of energy (J).', 20),
  (d_id, 'What is energy conservation?', 'Energy cannot be created or destroyed, only transferred.', 21);

  -- Year 7 English - Grammar & Writing
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 English - Grammar & Writing', 'SYLLABUS: Parts of speech, sentence types, punctuation, writing skills', 'English', 7, 23, 20, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a noun?', 'A naming word (e.g. cat, London, happiness).', 0),
  (d_id, 'What is a verb?', 'A doing/action word (e.g. run, think, is).', 1),
  (d_id, 'What is an adjective?', 'A describing word for a noun (e.g. red, tall, exciting).', 2),
  (d_id, 'What is an adverb?', 'A word describing a verb (e.g. quickly, silently).', 3),
  (d_id, 'What is a pronoun?', 'A word that replaces a noun (e.g. he, she, it, they).', 4),
  (d_id, 'What is a preposition?', 'A word showing position/time (e.g. under, above, during).', 5),
  (d_id, 'What is a conjunction?', 'A joining word (e.g. and, but, because).', 6),
  (d_id, 'What is a simple sentence?', 'One main clause: Subject + Verb + Object (e.g. ''The dog barked'').', 7),
  (d_id, 'What is a compound sentence?', 'Two main clauses joined by a conjunction (e.g. ''I ran, and I jumped'').', 8),
  (d_id, 'What is a complex sentence?', 'A main clause plus a subordinate clause (e.g. ''When it rained, we stayed in'').', 9),
  (d_id, 'What is a full stop used for?', 'Ending a sentence.', 10),
  (d_id, 'What is a comma used for?', 'Separating items in a list or clauses for a pause.', 11),
  (d_id, 'What is an apostrophe used for?', 'Showing possession (Tom''s book) or omission (don''t).', 12),
  (d_id, 'What is direct speech?', 'The exact words spoken, in inverted commas ("Hello," she said).', 13),
  (d_id, 'What is a paragraph?', 'A group of sentences about one idea.', 14),
  (d_id, 'What is a simile?', 'Comparing using ''like'' or ''as'' (e.g. ''as brave as a lion'').', 15),
  (d_id, 'What is a metaphor?', 'Saying one thing IS another (e.g. ''life is a journey'').', 16),
  (d_id, 'What is personification?', 'Giving human qualities to non-human things (e.g. ''the wind whispered'').', 17),
  (d_id, 'What is alliteration?', 'Repeated consonant sounds at the start of words (e.g. ''silly soft snow'').', 18),
  (d_id, 'What is a colon used for?', 'Introducing a list or explanation.', 19),
  (d_id, 'What is a semicolon used for?', 'Joining two related main clauses without a conjunction.', 20),
  (d_id, 'What is a noun phrase?', 'A group of words built around a noun (e.g. ''the tall dark stranger'').', 21),
  (d_id, 'What does ''PEE'' stand for in analysis?', 'Point, Evidence, Explain.', 22);

  -- Year 7 History - Medieval Britain 1066-1500
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 History - Medieval Britain 1066-1500', 'SYLLABUS: Battle of Hastings, feudal system, castles, the Black Death, the Church', 'History', 7, 23, 46, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'When was the Battle of Hastings?', '1066.', 0),
  (d_id, 'Who fought at the Battle of Hastings?', 'William of Normandy (Harold Godwinson).', 1),
  (d_id, 'Who won the Battle of Hastings?', 'William the Conqueror.', 2),
  (d_id, 'What was the Bayeux Tapestry?', 'A tapestry showing the Norman conquest of England.', 3),
  (d_id, 'What was the feudal system?', 'A hierarchy: King, nobles, knights, peasants - each owed loyalty and service.', 4),
  (d_id, 'What was a motte and bailey castle?', 'An early castle with a mound (motte) and enclosed courtyard (bailey), built of wood.', 5),
  (d_id, 'Why did castles change to stone?', 'For greater defence against attack.', 6),
  (d_id, 'What was the Domesday Book?', 'A record of all land and property in England, ordered by William in 1086.', 7),
  (d_id, 'What is the Magna Carta?', 'A charter of rights forced on King John in 1215, limiting royal power.', 8),
  (d_id, 'What was the Black Death?', 'A deadly plague that hit England in 1348, killing around a third of the population.', 9),
  (d_id, 'How was the Black Death spread?', 'By fleas on rats (bubonic plague) and coughing (pneumonic).', 10),
  (d_id, 'What happened to wages after the Black Death?', 'They rose because labour was scarce; peasants gained power.', 11),
  (d_id, 'What was the Peasants'' Revolt?', 'A 1381 uprising against the poll tax and serfdom, led by Wat Tyler.', 12),
  (d_id, 'How powerful was the medieval Church?', 'Very powerful - it controlled education, charity, and claimed to save souls.', 13),
  (d_id, 'What was a tithe?', 'A tenth of produce given to the Church.', 14),
  (d_id, 'What did knights do?', 'They fought for their lord and owned land in return for military service.', 15),
  (d_id, 'What was a manor?', 'The lord''s estate with the village, fields, and church.', 16),
  (d_id, 'What did peasants do?', 'They farmed the land, paid rent in produce, and had few freedoms.', 17),
  (d_id, 'What was the three-field system?', 'Crop rotation where one of three fields was left fallow each year.', 18),
  (d_id, 'Who was Henry II?', 'A medieval king famous for legal reforms and conflict with Thomas Becket.', 19),
  (d_id, 'What happened to Thomas Becket?', 'He was murdered in Canterbury Cathedral in 1170, allegedly on the king''s orders.', 20),
  (d_id, 'Why were medieval towns growing?', 'Trade increased and some people moved from farms to towns for work.', 21),
  (d_id, 'What was the role of monasteries?', 'Prayer, charity, education, and copying manuscripts.', 22);

  -- Year 7 Geography - Map Skills & Weather
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Geography - Map Skills & Weather', 'SYLLABUS: Map symbols, grid references, compass, weather, climate', 'Geography', 7, 23, 21, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a compass?', 'An instrument showing direction; eight points include N, NE, E, SE, S, SW, W, NW.', 0),
  (d_id, 'How many degrees is North on a compass?', '0° (or 360°).', 1),
  (d_id, 'What are four-figure grid references?', 'Two pairs of numbers locating a grid square on a map.', 2),
  (d_id, 'What are six-figure grid references?', 'More precise locations (to 100m) inside a grid square.', 3),
  (d_id, 'What is a scale on a map?', 'The ratio between distance on the map and real distance (e.g. 1:25,000).', 4),
  (d_id, 'On a 1:50,000 map, how many km is 2cm?', '1 km (1cm = 500m).', 5),
  (d_id, 'What does a blue line on a map usually show?', 'A river or stream.', 6),
  (d_id, 'What does the spot height show?', 'Exact height above sea level at that point.', 7),
  (d_id, 'What is contour height?', 'Lines joining points of equal height; close together = steep.', 8),
  (d_id, 'What is weather?', 'Day-to-day conditions of the atmosphere in a place.', 9),
  (d_id, 'What is climate?', 'Average weather conditions over a long period (30 years).', 10),
  (d_id, 'What instruments measure rainfall?', 'Rain gauge.', 11),
  (d_id, 'What instrument measures wind speed?', 'Anemometer.', 12),
  (d_id, 'What instrument measures temperature?', 'Thermometer (in a Stevenson screen).', 13),
  (d_id, 'What instrument measures air pressure?', 'Barometer.', 14),
  (d_id, 'Which direction does wind normally come from in the UK?', 'The south-west (westerlies).', 15),
  (d_id, 'Why does the UK get so much rain?', 'Prevailing south-westerly winds bring moist air from the Atlantic; relief rainfall over hills.', 16),
  (d_id, 'What is relief rainfall?', 'Rain caused by moist air rising over high land, cooling and condensing.', 17),
  (d_id, 'What is a depression?', 'A low-pressure system bringing clouds and rain.', 18),
  (d_id, 'What is an anticyclone?', 'A high-pressure system bringing calm, settled weather.', 19),
  (d_id, 'What is condensation?', 'Water vapour turning to liquid droplets as air cools.', 20),
  (d_id, 'What is precipitation?', 'Any form of water falling from clouds (rain, snow, hail, sleet).', 21),
  (d_id, 'What is the water cycle?', 'Evaporation, condensation, precipitation, collection - the movement of water.', 22);

  -- Year 7 Geography - Settlement & Population
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Geography - Settlement & Population', 'SYLLABUS: Settlement types, land use, population distribution, migration', 'Geography', 7, 22, 57, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a settlement?', 'A place where people live, from hamlet to megacity.', 0),
  (d_id, 'What is site and situation?', 'Site = land the settlement is on; situation = position relative to surroundings.', 1),
  (d_id, 'Why did settlements grow near rivers?', 'For water, transport, and fertile soil.', 2),
  (d_id, 'What is a hamlet?', 'A very small settlement with no church/shop.', 3),
  (d_id, 'What is a village?', 'A small settlement with basic services (church, shop).', 4),
  (d_id, 'What is a town?', 'A larger settlement with a market and more services.', 5),
  (d_id, 'What is a city?', 'A large settlement with a cathedral/legal status and many services.', 6),
  (d_id, 'What is a megacity?', 'A city with over 10 million people.', 7),
  (d_id, 'What is urbanisation?', 'The increasing share of people living in towns and cities.', 8),
  (d_id, 'What is the Central Business District (CBD)?', 'The commercial centre with shops and offices.', 9),
  (d_id, 'Why do people migrate to cities?', 'Jobs, education, healthcare (pull factors) and because rural areas lack opportunities (push).', 10),
  (d_id, 'What is a push factor?', 'Something that drives people away from a place (e.g. war, famine).', 11),
  (d_id, 'What is a pull factor?', 'Something that attracts people to a place (e.g. jobs, safety).', 12),
  (d_id, 'What is population density?', 'Number of people per km².', 13),
  (d_id, 'Why is the UK population denser in the south-east?', 'Better jobs, flatter land, milder climate, historic trade links.', 14),
  (d_id, 'What is a settlement hierarchy?', 'Ordering of settlements by size and number of services (hamlet < village < town < city).', 15),
  (d_id, 'What is green belt land?', 'Protected open land around cities to stop urban sprawl.', 16),
  (d_id, 'What is urban sprawl?', 'The unplanned growth of cities onto surrounding countryside.', 17),
  (d_id, 'What is a rural area?', 'Countryside with low population density.', 18),
  (d_id, 'What is a counter-urbanisation?', 'Movement of people from cities back to rural areas.', 19),
  (d_id, 'What are the benefits of living in a city?', 'More jobs, services, entertainment, and transport links.', 20),
  (d_id, 'What are the problems of cities?', 'Traffic congestion, pollution, housing shortages, high living costs.', 21);

  -- Year 7 Computing - Computer Systems & E-Safety
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 7 Computing - Computer Systems & E-Safety', 'SYLLABUS: Hardware, software, input/output, online safety', 'Computer Science', 7, 23, 28, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is hardware?', 'The physical parts of a computer (e.g. CPU, RAM, keyboard).', 0),
  (d_id, 'What is software?', 'Programs and instructions that run on hardware.', 1),
  (d_id, 'What does CPU stand for?', 'Central Processing Unit - the brain of the computer.', 2),
  (d_id, 'What is RAM?', 'Random Access Memory - temporary, fast storage for running programs; lost when powered off.', 3),
  (d_id, 'What is ROM?', 'Read-Only Memory - permanent storage, holds the boot instructions.', 4),
  (d_id, 'What is storage?', 'Long-term data saving (e.g. hard drive, SSD).', 5),
  (d_id, 'Give examples of input devices.', 'Keyboard, mouse, microphone, scanner, touchscreen.', 6),
  (d_id, 'Give examples of output devices.', 'Monitor, speaker, printer.', 7),
  (d_id, 'What is an operating system?', 'Software that manages hardware and software (e.g. Windows, macOS, Linux).', 8),
  (d_id, 'What is a peripheral?', 'A device connected to the computer (input or output).', 9),
  (d_id, 'What is a password?', 'A secret combination of characters used to verify identity.', 10),
  (d_id, 'What makes a strong password?', 'Long, with a mix of upper/lower case, numbers, and symbols; not reused.', 11),
  (d_id, 'What is phishing?', 'A scam tricking users into revealing personal data via fake messages/websites.', 12),
  (d_id, 'What is a virus?', 'Malicious software that copies itself and can damage files.', 13),
  (d_id, 'What is malware?', 'Any software designed to harm or exploit (viruses, worms, trojans, ransomware).', 14),
  (d_id, 'What should you do if someone asks for personal info online?', 'Do not share it; tell a trusted adult; report/block.', 15),
  (d_id, 'What is cyberbullying?', 'Using technology to bully or harass someone.', 16),
  (d_id, 'How can you stay safe on social media?', 'Private accounts, don''t accept strangers, think before posting.', 17),
  (d_id, 'What is your ''digital footprint''?', 'The trail of data you leave online; it is hard to remove.', 18),
  (d_id, 'What is copyright?', 'The legal right of a creator to control how their work is used.', 19),
  (d_id, 'What is a backup?', 'A copy of data kept in case the original is lost.', 20),
  (d_id, 'What is the difference between a file and a folder?', 'A file holds data; a folder organises files.', 21),
  (d_id, 'Why should you log out of public computers?', 'To stop others accessing your accounts.', 22);

  -- Year 8 Maths - Ratio, Proportion & Percentages
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Maths - Ratio, Proportion & Percentages', 'SYLLABUS: Ratios, proportion, speed, percentage change, exchange rates', 'Mathematics', 8, 24, 25, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Simplify the ratio 12:16.', '3:4 (divide both by 4).', 0),
  (d_id, 'Divide £50 in the ratio 3:2.', '£30 : £20 (5 parts total, £10 per part).', 1),
  (d_id, 'What does ''scale factor'' mean?', 'The number you multiply by to enlarge/shrink a shape or quantity.', 2),
  (d_id, 'Two quantities are directly proportional if...', 'As one increases, the other increases at the same rate (a constant multiple).', 3),
  (d_id, 'If 5 apples cost £1.50, how much do 8 cost?', '£2.40 (£0.30 each).', 4),
  (d_id, 'What is the unitary method?', 'Finding the value of one item first, then scaling up.', 5),
  (d_id, 'What is speed?', 'Distance ÷ time.', 6),
  (d_id, 'A car travels 120 miles in 2 hours. Average speed?', '60 mph.', 7),
  (d_id, 'What is density?', 'Mass ÷ volume.', 8),
  (d_id, 'What is the formula for percentage change?', '(change ÷ original) x 100.', 9),
  (d_id, 'Increase 40 by 15%.', '46 (15% of 40 = 6).', 10),
  (d_id, 'Decrease 200 by 30%.', '140.', 11),
  (d_id, 'Express 0.2 as a percentage.', '20%.', 12),
  (d_id, 'Express 0.2 as a fraction.', '1/5.', 13),
  (d_id, 'What is a ratio?', 'A comparison of two or more quantities, e.g. 2:5.', 14),
  (d_id, 'What is the exchange rate?', 'The value of one currency in terms of another.', 15),
  (d_id, 'If £1 = $1.30, how many dollars is £50?', '$65.', 16),
  (d_id, 'If £1 = €1.15, how many pounds is €69?', '£60 (divide by 1.15).', 17),
  (d_id, 'What is 10% of 460?', '46.', 18),
  (d_id, 'What is 1% of 460?', '4.6.', 19),
  (d_id, 'A £120 jacket is reduced by 25%. New price?', '£90.', 20),
  (d_id, 'What is the multiplier to increase by 12%?', '1.12.', 21),
  (d_id, 'What is the multiplier to decrease by 30%?', '0.70.', 22),
  (d_id, 'Recipe for 6 people needs 300g flour. For 9 people?', '450g (per person 50g).', 23);

  -- Year 8 Maths - Equations, Inequalities & Sequences
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Maths - Equations, Inequalities & Sequences', 'SYLLABUS: Solving equations, brackets, inequalities, nth term', 'Mathematics', 8, 23, 37, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Solve 2x + 3 = 15.', 'x = 6.', 0),
  (d_id, 'Solve 3x - 7 = 14.', 'x = 7.', 1),
  (d_id, 'Solve 5x + 2 = 3x + 10.', 'x = 4 (subtract 3x, then 2 from both sides).', 2),
  (d_id, 'Solve 4(x - 3) = 20.', 'x = 8 (expand: 4x - 12 = 20).', 3),
  (d_id, 'What is an inequality?', 'A statement using <, >, ≤, ≥ comparing two values.', 4),
  (d_id, 'Solve x + 5 < 12.', 'x < 7.', 5),
  (d_id, 'Solve 2x ≥ 10.', 'x ≥ 5.', 6),
  (d_id, 'What does the ≤ symbol mean?', 'Less than or equal to.', 7),
  (d_id, 'What is the nth term of 3, 6, 9, 12...?', '3n.', 8),
  (d_id, 'What is the nth term of 2, 5, 8, 11...?', '3n - 1.', 9),
  (d_id, 'What is the nth term of 1, 4, 9, 16...?', 'n².', 10),
  (d_id, 'What is the first difference of a linear sequence?', 'The constant amount added each time (e.g. +3).', 11),
  (d_id, 'Find the 10th term of 5n + 2.', '52.', 12),
  (d_id, 'What is a Fibonacci sequence?', 'Each term is the sum of the previous two (1, 1, 2, 3, 5...).', 13),
  (d_id, 'What does ''solve'' mean?', 'Find the value(s) of the variable that make the equation true.', 14),
  (d_id, 'Solve x/4 = 9.', 'x = 36.', 15),
  (d_id, 'Solve 2y + 7 = y + 12.', 'y = 5.', 16),
  (d_id, 'What is the coefficient of y in 3y?', '3.', 17),
  (d_id, 'What is the term with no variable called?', 'A constant (e.g. 7 in 3x + 7).', 18),
  (d_id, 'What is the nth term of 7, 9, 11, 13...?', '2n + 5.', 19),
  (d_id, 'What does the > symbol mean?', 'Greater than.', 20),
  (d_id, 'Solve 6x - 4 = 3x + 11.', 'x = 5.', 21),
  (d_id, 'What is a formula?', 'An equation showing a general rule, e.g. A = l x w.', 22);

  -- Year 8 Maths - Geometry: Angles & 2D Shapes
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Maths - Geometry: Angles & 2D Shapes', 'SYLLABUS: Angle rules, parallel lines, polygons, Pythagoras intro', 'Mathematics', 8, 24, 33, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are vertically opposite angles?', 'Angles opposite each other when two lines cross; they are equal.', 0),
  (d_id, 'What are corresponding angles?', 'Equal angles in matching positions on parallel lines.', 1),
  (d_id, 'What are alternate angles?', 'Equal angles on opposite sides of a transversal (Z shape).', 2),
  (d_id, 'What are co-interior angles on parallel lines?', 'They add to 180 degrees (C shape).', 3),
  (d_id, 'What is a transversal?', 'A line crossing two or more parallel lines.', 4),
  (d_id, 'Sum of interior angles of a polygon?', '(n - 2) x 180, where n = number of sides.', 5),
  (d_id, 'What is the interior angle of a regular hexagon?', '120 degrees (sum 720 / 6).', 6),
  (d_id, 'What is the exterior angle of a regular octagon?', '45 degrees (360 / 8).', 7),
  (d_id, 'What do exterior angles of any polygon add to?', '360 degrees.', 8),
  (d_id, 'What is Pythagoras'' theorem?', 'a² + b² = c², where c is the hypotenuse.', 9),
  (d_id, 'Find the hypotenuse of a triangle with sides 3 and 4.', '5 (9 + 16 = 25).', 10),
  (d_id, 'Find the missing side of a triangle with hypotenuse 10 and side 6.', '8 (100 - 36 = 64).', 11),
  (d_id, 'What is the hypotenuse?', 'The longest side, opposite the right angle.', 12),
  (d_id, 'What is the area of a trapezium?', '1/2 x (a + b) x height.', 13),
  (d_id, 'What is a kite?', 'A quadrilateral with two pairs of adjacent equal sides.', 14),
  (d_id, 'What is the area of a circle?', 'π x r².', 15),
  (d_id, 'What is the circumference of a circle?', 'π x d (or 2πr).', 16),
  (d_id, 'Find the circumference of a circle with radius 7cm (π = 22/7).', '44 cm (2 x 22/7 x 7).', 17),
  (d_id, 'What is a reflection?', 'A flip of a shape over a mirror line.', 18),
  (d_id, 'What is a rotation?', 'Turning a shape around a point by an angle.', 19),
  (d_id, 'What is a translation?', 'Sliding a shape without rotating or flipping it.', 20),
  (d_id, 'What is an enlargement?', 'Making a shape bigger/smaller by a scale factor from a centre.', 21),
  (d_id, 'What does ''congruent'' mean?', 'Same shape and size.', 22),
  (d_id, 'What does ''similar'' mean?', 'Same shape but different size (angles equal, sides proportional).', 23);

  -- Year 8 Science - Chemical Reactions
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Science - Chemical Reactions', 'SYLLABUS: Elements, compounds, mixtures, chemical reactions, acids and alkalis', 'Science', 8, 23, 50, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is an element?', 'A substance made of only one type of atom.', 0),
  (d_id, 'How many elements are there?', 'Around 118.', 1),
  (d_id, 'What is a compound?', 'Two or more elements chemically combined (e.g. H2O, CO2).', 2),
  (d_id, 'What is a mixture?', 'Two or more substances not chemically combined; can be separated.', 3),
  (d_id, 'How is a mixture different from a compound?', 'A mixture can be separated physically; a compound needs a chemical reaction.', 4),
  (d_id, 'What is the chemical formula for water?', 'H2O.', 5),
  (d_id, 'What is the chemical formula for carbon dioxide?', 'CO2.', 6),
  (d_id, 'What is a chemical reaction?', 'A process forming new substances with different properties.', 7),
  (d_id, 'Give a sign of a chemical reaction.', 'Colour change, gas produced, temperature change, precipitate formed.', 8),
  (d_id, 'What is the law of conservation of mass?', 'No atoms are created or destroyed in a reaction; mass stays the same.', 9),
  (d_id, 'What is oxidation?', 'A reaction with oxygen.', 10),
  (d_id, 'What is combustion?', 'Burning a fuel in oxygen, releasing energy.', 11),
  (d_id, 'What is thermal decomposition?', 'Breaking down a substance by heating.', 12),
  (d_id, 'What is an acid?', 'A substance with pH below 7 that forms hydrogen ions (H+).', 13),
  (d_id, 'What is an alkali?', 'A soluble base with pH above 7 that forms hydroxide ions (OH-).', 14),
  (d_id, 'What is pH 7?', 'Neutral (e.g. pure water).', 15),
  (d_id, 'What colour does universal indicator turn in acid?', 'Red/orange.', 16),
  (d_id, 'What colour does universal indicator turn in alkali?', 'Blue/purple.', 17),
  (d_id, 'What do acids + metals produce?', 'Salt + hydrogen gas.', 18),
  (d_id, 'What do acids + bases/alkalis produce?', 'Salt + water (neutralisation).', 19),
  (d_id, 'What do acids + carbonates produce?', 'Salt + water + carbon dioxide.', 20),
  (d_id, 'What is neutralisation?', 'Acid + alkali -> salt + water; pH moves towards 7.', 21),
  (d_id, 'What is a salt?', 'The product of neutralisation, e.g. sodium chloride.', 22);

  -- Year 8 Science - Reproduction & Life Cycles
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Science - Reproduction & Life Cycles', 'SYLLABUS: Human reproduction, plant reproduction, growth', 'Science', 8, 23, 53, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is reproduction?', 'The process of producing offspring.', 0),
  (d_id, 'What is sexual reproduction?', 'Fusing male and female gametes; offspring have genes from both parents.', 1),
  (d_id, 'What is asexual reproduction?', 'One parent produces identical offspring (no gametes), e.g. bacteria, strawberry runners.', 2),
  (d_id, 'What is a gamete?', 'A sex cell: sperm, egg, pollen.', 3),
  (d_id, 'How many chromosomes in a human body cell?', '46 (23 pairs).', 4),
  (d_id, 'How many chromosomes in a gamete?', '23.', 5),
  (d_id, 'Where does fertilisation occur in humans?', 'In the oviduct (fallopian tube).', 6),
  (d_id, 'What is a zygote?', 'A fertilised egg cell.', 7),
  (d_id, 'What is the placenta?', 'Organ supplying oxygen and nutrients to the foetus and removing waste.', 8),
  (d_id, 'How long is human pregnancy?', 'About 9 months (38-40 weeks).', 9),
  (d_id, 'What does the menstrual cycle do?', 'Prepares the uterus for pregnancy, roughly every 28 days.', 10),
  (d_id, 'What is the male gamete?', 'Sperm.', 11),
  (d_id, 'What is the female gamete?', 'Egg (ovum).', 12),
  (d_id, 'Where is the egg produced?', 'The ovary.', 13),
  (d_id, 'Where is sperm produced?', 'The testes.', 14),
  (d_id, 'What is pollination?', 'Transfer of pollen from anther to stigma in plants.', 15),
  (d_id, 'What is wind pollination?', 'Small, light pollen carried by the wind.', 16),
  (d_id, 'What is insect pollination?', 'Large sticky pollen carried by insects attracted to colourful flowers.', 17),
  (d_id, 'What is germination?', 'When a seed starts to grow, needing water, oxygen, and warmth.', 18),
  (d_id, 'What is a fruit?', 'A ripened ovary containing seeds.', 19),
  (d_id, 'What is a seed?', 'An embryo plant with a food store, protected by a coat.', 20),
  (d_id, 'What is a clone?', 'An organism genetically identical to its parent.', 21),
  (d_id, 'Why are identical twins clones?', 'They develop from one zygote that splits.', 22);

  -- Year 8 Science - Light, Sound & Space
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Science - Light, Sound & Space', 'SYLLABUS: Light, sound waves, the solar system, day and night', 'Science', 8, 23, 29, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Is light a wave or particle?', 'Light behaves as a wave (and as particles - photons).', 0),
  (d_id, 'What is the speed of light?', '300,000,000 m/s (3 x 10^8 m/s).', 1),
  (d_id, 'What is reflection?', 'Bouncing of light off a surface; angle of incidence = angle of reflection.', 2),
  (d_id, 'What is refraction?', 'Bending of light as it changes speed between mediums.', 3),
  (d_id, 'Why does a straw in water look bent?', 'Refraction of light at the water surface.', 4),
  (d_id, 'What is a concave lens?', 'A lens that spreads light out (thinner in the middle); used in glasses for short sight.', 5),
  (d_id, 'What is a convex lens?', 'A lens that brings light to a focus; magnifying glass.', 6),
  (d_id, 'What colour is white light made of?', 'A spectrum of colours: red, orange, yellow, green, blue, indigo, violet.', 7),
  (d_id, 'What is the visible spectrum order from lowest to highest frequency?', 'Red, orange, yellow, green, blue, indigo, violet.', 8),
  (d_id, 'What is sound?', 'A longitudinal wave of vibrations travelling through a medium.', 9),
  (d_id, 'Can sound travel in a vacuum?', 'No - it needs particles to travel.', 10),
  (d_id, 'What is the speed of sound in air?', 'About 340 m/s.', 11),
  (d_id, 'What is frequency?', 'Number of waves per second, measured in hertz (Hz).', 12),
  (d_id, 'What determines the pitch of a sound?', 'Frequency (higher frequency = higher pitch).', 13),
  (d_id, 'What determines the loudness of a sound?', 'Amplitude (larger amplitude = louder).', 14),
  (d_id, 'What is ultrasound?', 'Sound above 20,000 Hz, used in medicine and echolocation.', 15),
  (d_id, 'Name the planets in order.', 'Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune.', 16),
  (d_id, 'What is at the centre of the solar system?', 'The Sun.', 17),
  (d_id, 'What causes day and night?', 'Earth''s rotation on its axis (24 hours).', 18),
  (d_id, 'What causes the seasons?', 'Earth''s tilted axis orbiting the Sun.', 19),
  (d_id, 'What is a satellite?', 'An object orbiting a planet; the Moon is a natural satellite.', 20),
  (d_id, 'How long does the Moon take to orbit Earth?', 'About 28 days (a month).', 21),
  (d_id, 'What causes the phases of the Moon?', 'The changing position of the Moon relative to the Sun as seen from Earth.', 22);

  -- Year 8 History - Tudors & Stuarts
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 History - Tudors & Stuarts', 'SYLLABUS: Henry VIII, Reformation, Elizabeth, Civil War, 1666', 'History', 8, 23, 41, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who founded the Tudor dynasty?', 'Henry VII, after winning at Bosworth in 1485.', 0),
  (d_id, 'How many wives did Henry VIII have?', 'Six.', 1),
  (d_id, 'Why did Henry VIII break with Rome?', 'Pope refused to annul his marriage to Catherine of Aragon.', 2),
  (d_id, 'What was the Reformation?', 'The break from the Catholic Church and creation of the Church of England.', 3),
  (d_id, 'What was the Act of Supremacy (1534)?', 'Made Henry VIII the head of the Church in England.', 4),
  (d_id, 'What was the dissolution of the monasteries?', 'Henry VIII closed monasteries and sold their land (1536-40).', 5),
  (d_id, 'Why was Anne Boleyn executed?', 'She was accused of treason and adultery.', 6),
  (d_id, 'Who was the ''Bloody Mary''?', 'Mary I, who restored Catholicism and burned Protestants.', 7),
  (d_id, 'Who was Elizabeth I?', 'The last Tudor monarch (1558-1603), known for the Armada victory.', 8),
  (d_id, 'What was the Spanish Armada?', 'A 1588 Spanish fleet sent to invade England; defeated by storms and the English navy.', 9),
  (d_id, 'What was the Golden Age?', 'Elizabethan era of theatre (Shakespeare), exploration (Drake), and peace.', 10),
  (d_id, 'Why did Mary, Queen of Scots, lose her head?', 'She was executed in 1587 after being linked to plots against Elizabeth.', 11),
  (d_id, 'Who were the Stuarts?', 'The dynasty ruling Britain 1603-1714, starting with James I.', 12),
  (d_id, 'What was the Gunpowder Plot?', '1605 attempt by Guy Fawkes to blow up Parliament.', 13),
  (d_id, 'What caused the English Civil War (1642-49)?', 'Conflict between Charles I and Parliament over power, money, and religion.', 14),
  (d_id, 'Who were the Roundheads?', 'Parliamentarians, led by Oliver Cromwell.', 15),
  (d_id, 'Who were the Cavaliers?', 'Royalists who supported Charles I.', 16),
  (d_id, 'What happened to Charles I in 1649?', 'He was executed; England became a republic.', 17),
  (d_id, 'What was the Commonwealth?', 'The period without a monarch when Cromwell ruled (1653 as Lord Protector).', 18),
  (d_id, 'What happened in 1660?', 'The Restoration: Charles II returned as king.', 19),
  (d_id, 'What was the Great Plague of 1665?', 'A bubonic plague outbreak in London killing ~100,000.', 20),
  (d_id, 'What was the Great Fire of London?', '1666 fire that destroyed much of the city; led to brick rebuilding.', 21),
  (d_id, 'What was the Glorious Revolution (1688)?', 'William and Mary replaced James II with little bloodshed; limited royal power.', 22);

  -- Year 8 Geography - Ecosystems & Climate
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Geography - Ecosystems & Climate', 'SYLLABUS: Ecosystems, biomes, rainforests, deserts, climate change', 'Geography', 8, 23, 35, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is an ecosystem?', 'Living organisms (biotic) and non-living parts (abiotic) interacting in an area.', 0),
  (d_id, 'What are the components of an ecosystem?', 'Producers, consumers, decomposers, plus sunlight, soil, water.', 1),
  (d_id, 'What is a producer?', 'A plant making food by photosynthesis.', 2),
  (d_id, 'What is a food chain?', 'The flow of energy: producer -> primary consumer -> secondary consumer.', 3),
  (d_id, 'What is a decomposer?', 'Organisms like fungi/bacteria that break down dead matter and recycle nutrients.', 4),
  (d_id, 'What is a biome?', 'A large-scale ecosystem (e.g. rainforest, desert, tundra) with similar climate and life.', 5),
  (d_id, 'What biome is the UK?', 'Temperate deciduous forest.', 6),
  (d_id, 'Why are rainforests important?', 'High biodiversity, oxygen production, carbon storage, climate regulation.', 7),
  (d_id, 'What is the climate of a tropical rainforest?', 'Hot and wet all year (25-28°C, 2000mm+ rain).', 8),
  (d_id, 'What are the layers of the rainforest?', 'Emergent, canopy, understorey, forest floor.', 9),
  (d_id, 'What is deforestation?', 'Cutting down forests, causing habitat loss and carbon release.', 10),
  (d_id, 'What causes deforestation in the Amazon?', 'Cattle ranching, soy farming, logging, mining, road building.', 11),
  (d_id, 'What is biodiversity?', 'The variety of living species in an ecosystem.', 12),
  (d_id, 'What is a desert ecosystem?', 'Very dry biome (under 250mm rain/year) with extremes of temperature.', 13),
  (d_id, 'How do desert plants adapt?', 'Deep roots, water storage (cacti), small or waxy leaves.', 14),
  (d_id, 'What is the greenhouse effect?', 'Gases (CO2, methane) trap heat, keeping Earth warm.', 15),
  (d_id, 'Which human activities increase greenhouse gases?', 'Burning fossil fuels, deforestation, industry, agriculture.', 16),
  (d_id, 'What are the effects of climate change?', 'Rising sea levels, extreme weather, habitat loss, droughts.', 17),
  (d_id, 'What is mitigation?', 'Reducing the causes of climate change (renewables, carbon capture).', 18),
  (d_id, 'What is adaptation to climate change?', 'Adjusting to its effects (flood defences, drought-resistant crops).', 19),
  (d_id, 'What is a carbon sink?', 'Something that absorbs more carbon than it releases (oceans, forests).', 20),
  (d_id, 'What is an endangered species?', 'A species at risk of extinction.', 21),
  (d_id, 'Why protect ecosystems?', 'For biodiversity, ecosystem services, and future generations.', 22);

  -- Year 8 Computing - Programming with Python
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 8 Computing - Programming with Python', 'SYLLABUS: Sequencing, selection, iteration, variables, simple Python', 'Computer Science', 8, 23, 47, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a program?', 'A set of instructions a computer executes.', 0),
  (d_id, 'What is sequencing?', 'Executing instructions in order.', 1),
  (d_id, 'What is selection?', 'Making a choice using IF/ELSE conditions.', 2),
  (d_id, 'What is iteration?', 'Repeating code using loops (FOR and WHILE).', 3),
  (d_id, 'What is a variable?', 'A named storage for data that can change.', 4),
  (d_id, 'How do you create a variable in Python?', 'name = value, e.g. score = 10.', 5),
  (d_id, 'What does print() do in Python?', 'Outputs text to the screen.', 6),
  (d_id, 'What does input() do in Python?', 'Gets text typed by the user.', 7),
  (d_id, 'What data type is 42?', 'Integer.', 8),
  (d_id, 'What data type is 3.14?', 'Float.', 9),
  (d_id, 'What data type is "hello"?', 'String.', 10),
  (d_id, 'What data type is True/False?', 'Boolean.', 11),
  (d_id, 'What is a condition?', 'A check that evaluates to True or False (e.g. x > 5).', 12),
  (d_id, 'What does == mean in Python?', 'Comparison for equality (not assignment).', 13),
  (d_id, 'What is the difference between = and == ?', '''='' assigns a value; ''=='' compares values.', 14),
  (d_id, 'What is a FOR loop used for?', 'Repeating a fixed number of times.', 15),
  (d_id, 'What is a WHILE loop used for?', 'Repeating while a condition is true.', 16),
  (d_id, 'What is a bug?', 'An error in code that stops it working correctly.', 17),
  (d_id, 'What is debugging?', 'Finding and fixing errors in code.', 18),
  (d_id, 'What is an algorithm?', 'A step-by-step set of rules to solve a problem.', 19),
  (d_id, 'What does the modulo operator % do?', 'Returns the remainder of a division (e.g. 10 % 3 = 1).', 20),
  (d_id, 'What does len() do in Python?', 'Returns the length of a string or list.', 21),
  (d_id, 'What is a comment in Python?', 'Text starting with # that is ignored by the program.', 22);

  -- Year 9 Maths - Indices, Standard Form & Quadratics
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Maths - Indices, Standard Form & Quadratics', 'SYLLABUS: Laws of indices, standard form, expanding, factorising, solving quadratics', 'Mathematics', 9, 23, 32, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is 2^5?', '32.', 0),
  (d_id, 'What does x^0 equal?', '1 (any number to the power 0 is 1).', 1),
  (d_id, 'What does x^-2 equal?', '1/x² (negative power = reciprocal).', 2),
  (d_id, 'Simplify x³ x x⁴.', 'x⁷ (add powers when multiplying).', 3),
  (d_id, 'Simplify x⁷ ÷ x³.', 'x⁴ (subtract powers when dividing).', 4),
  (d_id, 'Simplify (x³)².', 'x⁶ (multiply powers).', 5),
  (d_id, 'Write 3000 in standard form.', '3 x 10³.', 6),
  (d_id, 'Write 0.0045 in standard form.', '4.5 x 10⁻³.', 7),
  (d_id, 'What is standard form used for?', 'Writing very large or very small numbers.', 8),
  (d_id, 'Expand x(x + 5).', 'x² + 5x.', 9),
  (d_id, 'Expand (x + 3)(x + 2).', 'x² + 5x + 6.', 10),
  (d_id, 'Expand (x + 4)².', 'x² + 8x + 16.', 11),
  (d_id, 'What is the difference of two squares?', 'x² - y² = (x + y)(x - y).', 12),
  (d_id, 'Factorise x² + 5x + 6.', '(x + 2)(x + 3).', 13),
  (d_id, 'Factorise x² - 9.', '(x + 3)(x - 3).', 14),
  (d_id, 'What is the difference between an expression and an equation?', 'An equation has an equals sign and can be solved.', 15),
  (d_id, 'Solve x² = 49.', 'x = ±7 (both positive and negative).', 16),
  (d_id, 'Solve x² - 5x + 6 = 0.', 'x = 2 or x = 3.', 17),
  (d_id, 'What are the roots of a quadratic?', 'The x-values where the graph crosses the x-axis (y = 0).', 18),
  (d_id, 'What is the discriminant?', 'b² - 4ac; positive = two roots, zero = one, negative = none.', 19),
  (d_id, 'Solve 2x² = 50.', 'x = ±5.', 20),
  (d_id, 'What is the nth term of 1, 4, 9, 16, 25?', 'n².', 21),
  (d_id, 'What is the quadratic formula?', 'x = (-b ± √(b² - 4ac)) / 2a.', 22);

  -- Year 9 Maths - Trigonometry & Graphs
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Maths - Trigonometry & Graphs', 'SYLLABUS: SOHCAHTOA, exact values, graphs of linear and quadratic functions', 'Mathematics', 9, 23, 50, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What does SOH CAH TOA stand for?', 'Sin = Opposite/Hypotenuse, Cos = Adjacent/Hypotenuse, Tan = Opposite/Adjacent.', 0),
  (d_id, 'What is sin of 30°?', '1/2.', 1),
  (d_id, 'What is cos of 60°?', '1/2.', 2),
  (d_id, 'What is tan of 45°?', '1.', 3),
  (d_id, 'What is sin of 90°?', '1.', 4),
  (d_id, 'What is cos of 0°?', '1.', 5),
  (d_id, 'How do you find a missing side using trigonometry?', 'Choose the correct ratio, substitute, and rearrange.', 6),
  (d_id, 'How do you find a missing angle?', 'Use inverse trig: sin⁻¹, cos⁻¹, tan⁻¹.', 7),
  (d_id, 'What is the equation of a straight line?', 'y = mx + c, where m is gradient and c is the y-intercept.', 8),
  (d_id, 'What is the gradient?', 'The steepness: (change in y)/(change in x).', 9),
  (d_id, 'What is the y-intercept?', 'Where the line crosses the y-axis.', 10),
  (d_id, 'What is the gradient of y = 3x + 2?', '3.', 11),
  (d_id, 'Where does y = 2x + 1 cross the y-axis?', 'At y = 1.', 12),
  (d_id, 'What shape is the graph of y = x²?', 'A U-shaped parabola.', 13),
  (d_id, 'What is the vertex of a parabola?', 'Its turning point (maximum or minimum).', 14),
  (d_id, 'What does the graph y = 1/x look like?', 'A hyperbola with two branches approaching the axes.', 15),
  (d_id, 'What are the coordinates of the y-intercept of y = x² + 4x + 3?', '(0, 3).', 16),
  (d_id, 'What are the x-intercepts of y = (x - 2)(x + 1)?', 'x = 2 and x = -1.', 17),
  (d_id, 'What is a distance-time graph gradient?', 'Speed.', 18),
  (d_id, 'What is a velocity-time graph gradient?', 'Acceleration.', 19),
  (d_id, 'What does a horizontal line on a distance-time graph mean?', 'The object is stationary.', 20),
  (d_id, 'What is a line of best fit?', 'A straight line through a scatter graph showing the trend.', 21),
  (d_id, 'What is correlation?', 'The relationship between two variables (positive, negative, or none).', 22);

  -- Year 9 Science - Energy, Electricity & Forces
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Science - Energy, Electricity & Forces', 'SYLLABUS: Energy transfer, electricity, circuits, forces and motion', 'Science', 9, 23, 36, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the law of conservation of energy?', 'Energy cannot be created or destroyed, only transferred.', 0),
  (d_id, 'Name energy stores.', 'Kinetic, gravitational potential, elastic, thermal, chemical, nuclear, magnetic.', 1),
  (d_id, 'What is useful energy?', 'Energy transferred to where it is wanted (e.g. light from a bulb).', 2),
  (d_id, 'What is wasted energy?', 'Energy transferred to unwanted stores, often thermal/heat.', 3),
  (d_id, 'What is efficiency?', '(useful energy output / total energy input) x 100%.', 4),
  (d_id, 'What is a renewable energy resource?', 'One that can be replenished (solar, wind, hydro, geothermal, biomass).', 5),
  (d_id, 'What is a non-renewable resource?', 'One that will run out (coal, oil, gas, nuclear).', 6),
  (d_id, 'What is voltage?', 'The energy per unit charge, measured in volts (V).', 7),
  (d_id, 'What is current?', 'The flow of charge, measured in amps (A).', 8),
  (d_id, 'What is resistance?', 'How much a component opposes current, measured in ohms (Ω).', 9),
  (d_id, 'What is Ohm''s law?', 'V = I x R.', 10),
  (d_id, 'What is a series circuit?', 'Components in one loop; current is the same, voltage is shared.', 11),
  (d_id, 'What is a parallel circuit?', 'Branches; voltage same across each, current splits.', 12),
  (d_id, 'What happens to the total resistance in series?', 'It adds up (R1 + R2 + ...).', 13),
  (d_id, 'What is a fuse?', 'A safety device that melts when current is too high.', 14),
  (d_id, 'What is static electricity?', 'Charge building up on a surface from rubbing (electrons moving).', 15),
  (d_id, 'What is Newton''s first law?', 'An object stays at rest or moves at constant velocity unless acted on by a resultant force.', 16),
  (d_id, 'What is Newton''s second law?', 'Force = mass x acceleration (F = ma).', 17),
  (d_id, 'What is Newton''s third law?', 'Every action has an equal and opposite reaction.', 18),
  (d_id, 'What is terminal velocity?', 'When weight equals drag, so acceleration stops.', 19),
  (d_id, 'What is momentum?', 'mass x velocity (kg m/s).', 20),
  (d_id, 'What is the unit of power?', 'The watt (W) = J/s.', 21),
  (d_id, 'What is work done?', 'force x distance (Joules).', 22);

  -- Year 9 Science - Genetics & Evolution
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Science - Genetics & Evolution', 'SYLLABUS: DNA, genes, inheritance, variation, natural selection', 'Science', 9, 23, 43, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What does DNA stand for?', 'Deoxyribonucleic acid.', 0),
  (d_id, 'What is DNA?', 'The molecule carrying genetic instructions, shaped as a double helix.', 1),
  (d_id, 'What is a gene?', 'A section of DNA coding for a protein/trait.', 2),
  (d_id, 'What is a chromosome?', 'A long coiled DNA molecule; humans have 46 in body cells.', 3),
  (d_id, 'What is an allele?', 'A different version of a gene (e.g. blue vs brown eyes).', 4),
  (d_id, 'What is a dominant allele?', 'One that shows its trait even with one copy (represented by a capital letter).', 5),
  (d_id, 'What is a recessive allele?', 'Only shows its trait with two copies (lowercase letter).', 6),
  (d_id, 'What is a genotype?', 'The allele combination (e.g. Bb).', 7),
  (d_id, 'What is a phenotype?', 'The physical appearance (e.g. brown eyes).', 8),
  (d_id, 'What does homozygous mean?', 'Two identical alleles (BB or bb).', 9),
  (d_id, 'What does heterozygous mean?', 'Two different alleles (Bb).', 10),
  (d_id, 'What is a Punnett square?', 'A grid predicting offspring genotypes from parent alleles.', 11),
  (d_id, 'If both parents are Bb (B dominant), what fraction of offspring is bb?', '1/4.', 12),
  (d_id, 'What is variation?', 'Differences between individuals of the same species.', 13),
  (d_id, 'What causes genetic variation?', 'Mutations, and the mixing of alleles in sexual reproduction.', 14),
  (d_id, 'What is natural selection?', 'Better-adapted individuals survive and reproduce, passing on their alleles.', 15),
  (d_id, 'Who proposed natural selection?', 'Charles Darwin (On the Origin of Species, 1859).', 16),
  (d_id, 'What is a mutation?', 'A change in DNA; can be harmful, beneficial, or neutral.', 17),
  (d_id, 'What is a fossil?', 'The preserved remains of ancient organisms showing evolution over time.', 18),
  (d_id, 'What is selective breeding?', 'Humans breeding organisms for desired traits.', 19),
  (d_id, 'What is genetic engineering?', 'Transferring a gene from one organism to another (e.g. insulin in bacteria).', 20),
  (d_id, 'What is cloning?', 'Making genetically identical copies of an organism.', 21),
  (d_id, 'Give an example of a genetic disorder.', 'Cystic fibrosis (recessive) or Huntington''s (dominant).', 22);

  -- Year 9 English - Poetry & Shakespeare
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 English - Poetry & Shakespeare', 'SYLLABUS: War poetry, unseen poetry analysis, Shakespeare skills', 'English', 9, 23, 27, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who wrote ''Dulce et Decorum Est''?', 'Wilfred Owen.', 0),
  (d_id, 'What does ''Dulce et Decorum Est'' mean?', '''It is sweet and honourable'' - the poem argues it is NOT sweet to die for one''s country.', 1),
  (d_id, 'What does Owen describe in the poem?', 'A gas attack during WWI and the horror of a soldier dying from chlorine gas.', 2),
  (d_id, 'What is irony?', 'When the outcome is opposite to expectation (e.g. Owen''s bitter title).', 3),
  (d_id, 'What is a stanza?', 'A group of lines in a poem (a verse).', 4),
  (d_id, 'What is rhyme scheme?', 'The pattern of rhymes, e.g. ABAB.', 5),
  (d_id, 'What is enjambment?', 'When a sentence runs over the end of a line without a pause.', 6),
  (d_id, 'What is a caesura?', 'A deliberate pause in the middle of a line.', 7),
  (d_id, 'What is imagery?', 'Descriptive language that creates pictures in the reader''s mind.', 8),
  (d_id, 'What is a sonnet?', 'A 14-line poem, often about love, with a turn (volta).', 9),
  (d_id, 'What is an iambic pentameter?', 'Ten syllables per line in a da-DUM pattern - like Shakespeare.', 10),
  (d_id, 'Who is the speaker in a poem?', 'The voice/persona narrating the poem (not always the poet).', 11),
  (d_id, 'What is a theme?', 'The central idea (e.g. conflict, loss, identity).', 12),
  (d_id, 'What is a metaphor?', 'A comparison saying something IS something else.', 13),
  (d_id, 'What is personification?', 'Giving human qualities to non-human things.', 14),
  (d_id, 'What is a dramatic monologue?', 'A poem spoken entirely by one character.', 15),
  (d_id, 'What is a ballad?', 'A narrative poem, often with a regular rhythm and refrain.', 16),
  (d_id, 'How do you analyse a poem?', 'Comment on language, structure, form, and sound - with quotes and effect.', 17),
  (d_id, 'What is the PEEL structure?', 'Point, Evidence, Explanation, Link.', 18),
  (d_id, 'Who wrote Romeo and Juliet?', 'William Shakespeare.', 19),
  (d_id, 'What is a tragedy?', 'A play where the hero''s downfall is caused by fate and/or a fatal flaw.', 20),
  (d_id, 'What is dramatic irony?', 'When the audience knows something the characters do not.', 21),
  (d_id, 'What is soliloquy?', 'A speech where a character speaks their thoughts alone on stage.', 22);

  -- Year 9 History - World War One
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 History - World War One', 'SYLLABUS: Causes of WWI, trench warfare, key battles, the Armistice', 'History', 9, 23, 24, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the four long-term causes of WWI?', 'Militarism, alliances, imperialism, and nationalism.', 0),
  (d_id, 'What was the Triple Entente?', 'Alliance of Britain, France, and Russia.', 1),
  (d_id, 'What was the Triple Alliance?', 'Alliance of Germany, Austria-Hungary, and Italy.', 2),
  (d_id, 'What was the spark that started WWI?', 'The assassination of Archduke Franz Ferdinand in Sarajevo, June 1914.', 3),
  (d_id, 'Who assassinated him?', 'Gavrilo Princip, a Bosnian Serb nationalist.', 4),
  (d_id, 'When did WWI begin?', 'August 1914.', 5),
  (d_id, 'What was the Schlieffen Plan?', 'Germany''s plan to knock out France quickly via Belgium, then fight Russia.', 6),
  (d_id, 'What is trench warfare?', 'Fighting from fortified ditches; static and deadly on the Western Front.', 7),
  (d_id, 'What was no man''s land?', 'The land between opposing trenches, full of craters and wire.', 8),
  (d_id, 'What was ''going over the top''?', 'Leaving the trench to attack across no man''s land.', 9),
  (d_id, 'What were the conditions in the trenches?', 'Mud, rats, lice, trench foot, disease, shelling, and fear.', 10),
  (d_id, 'What was trench foot?', 'A painful infection from feet being wet and cold in the trenches.', 11),
  (d_id, 'When was the Battle of the Somme?', '1916 - one of the bloodiest battles; ~1 million casualties.', 12),
  (d_id, 'What was the Somme famous for?', 'The first use of tanks (unreliable) and huge loss of life on day one.', 13),
  (d_id, 'What is ''machine gun'' impact on war?', 'It made frontal attacks suicidal, causing mass casualties.', 14),
  (d_id, 'What was conscription?', 'Forced military service, introduced in Britain in 1916.', 15),
  (d_id, 'What was the role of women in WWI?', 'Working in factories, farming, and as nurses while men fought.', 16),
  (d_id, 'Who was Walter Tull?', 'One of the first black British army officers, killed in 1918.', 17),
  (d_id, 'When did WWI end?', '11 November 1918 (the Armistice, 11am).', 18),
  (d_id, 'How many soldiers died in WWI?', 'About 10 million (military) plus millions of civilians.', 19),
  (d_id, 'What is a conscientious objector?', 'Someone who refused to fight for moral/religious reasons.', 20),
  (d_id, 'What is shell shock?', 'Now called PTSD - trauma from the horrors of war.', 21),
  (d_id, 'What was the Western Front?', 'The main line of trenches in France and Belgium.', 22);

  -- Year 9 Geography - Development & Globalisation
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Geography - Development & Globalisation', 'SYLLABUS: Development, indicators, globalisation, TNCs, fair trade', 'Geography', 9, 24, 24, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is development?', 'Progress in a country''s economy, society, and quality of life.', 0),
  (d_id, 'What is HDI?', 'Human Development Index - combines income, education, and life expectancy (0-1).', 1),
  (d_id, 'What is GDP?', 'Gross Domestic Product - total value of goods/services produced.', 2),
  (d_id, 'What is GDP per capita?', 'GDP divided by population - a measure of average wealth.', 3),
  (d_id, 'What is a developed country (HIC)?', 'High income country, e.g. USA, UK, Japan.', 4),
  (d_id, 'What is a developing country (LIC)?', 'Low income country, e.g. many in Africa and Asia.', 5),
  (d_id, 'What are the causes of uneven development?', 'Historical (colonisation), physical (climate, disease), economic (trade), political (conflict).', 6),
  (d_id, 'What is the development gap?', 'The divide between rich and poor countries.', 7),
  (d_id, 'What is globalisation?', 'The increasing interconnection of countries through trade, culture, and travel.', 8),
  (d_id, 'What is a TNC (transnational corporation)?', 'A company operating in many countries, e.g. Nike, McDonald''s.', 9),
  (d_id, 'What are the advantages of TNCs for developing countries?', 'Jobs, investment, infrastructure, technology transfer.', 10),
  (d_id, 'What are the disadvantages of TNCs for developing countries?', 'Low wages, poor conditions, profit leaves the country, environmental damage.', 11),
  (d_id, 'What is fair trade?', 'Trade that pays producers a fair price and supports communities.', 12),
  (d_id, 'What is aid?', 'Help given from richer to poorer countries (emergency, development, NGO).', 13),
  (d_id, 'What is a trade barrier?', 'Taxes or quotas limiting imports, keeping out goods from developing countries.', 14),
  (d_id, 'What is a migrant?', 'Someone who moves from one place to another.', 15),
  (d_id, 'What is a refugee?', 'Someone forced to flee their country due to war or persecution.', 16),
  (d_id, 'What are the causes of migration?', 'Push factors (poverty, war, climate) and pull factors (jobs, safety, family).', 17),
  (d_id, 'What is urbanisation in developing countries?', 'Rapid growth of cities as people leave rural areas.', 18),
  (d_id, 'What is a shanty town / informal settlement?', 'Unplanned housing on city edges with few services.', 19),
  (d_id, 'What is the Brandt Line?', 'An outdated divide showing rich north vs poor south.', 20),
  (d_id, 'What is sustainable development?', 'Meeting today''s needs without harming future generations.', 21),
  (d_id, 'What is a top-down development project?', 'A large, government/corporation-led project (e.g. large dam).', 22),
  (d_id, 'What is a bottom-up project?', 'A small, community-led project (e.g. solar panels for a village).', 23);

  -- Year 9 Computing - Networks & the Internet
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Year 9 Computing - Networks & the Internet', 'SYLLABUS: Networks, IP addresses, packets, the internet, security', 'Computer Science', 9, 23, 58, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a network?', 'Two or more devices connected to share data and resources.', 0),
  (d_id, 'What is a LAN?', 'Local Area Network - covers a small area like a school or office.', 1),
  (d_id, 'What is a WAN?', 'Wide Area Network - covers large areas; the internet is the biggest WAN.', 2),
  (d_id, 'What is the internet?', 'A global network of networks connected by routers.', 3),
  (d_id, 'What is the World Wide Web?', 'A collection of websites on the internet accessed via HTTP.', 4),
  (d_id, 'What is an IP address?', 'A unique numerical address identifying a device on a network.', 5),
  (d_id, 'What is a MAC address?', 'A physical hardware address unique to a network card.', 6),
  (d_id, 'What is a packet?', 'A chunk of data sent across a network, with header and payload.', 7),
  (d_id, 'What is packet switching?', 'Routing data in packets that can take different paths and are reassembled.', 8),
  (d_id, 'What is a router?', 'A device that forwards data between networks.', 9),
  (d_id, 'What is a switch?', 'A device connecting devices on a LAN and sending data only to the right one.', 10),
  (d_id, 'What is bandwidth?', 'The amount of data that can be transferred per second.', 11),
  (d_id, 'What is latency?', 'The delay before data starts to transfer.', 12),
  (d_id, 'What is the difference between wired and wireless?', 'Wired (ethernet) is faster/more reliable; wireless (Wi-Fi) is flexible.', 13),
  (d_id, 'What is encryption?', 'Scrambling data so only authorised people can read it.', 14),
  (d_id, 'What is HTTPS?', 'Secure HTTP using encryption for safe web browsing.', 15),
  (d_id, 'What is a firewall?', 'Software/hardware monitoring and blocking unauthorised network traffic.', 16),
  (d_id, 'What is a phishing attack?', 'Tricking users with fake messages to reveal sensitive data.', 17),
  (d_id, 'What is a DDoS attack?', 'Distributed Denial of Service - flooding a server to take it down.', 18),
  (d_id, 'What is a brute-force attack?', 'Guessing passwords by trying many combinations.', 19),
  (d_id, 'How can you protect against attacks?', 'Firewalls, strong passwords, encryption, updates, antivirus.', 20),
  (d_id, 'What is the ''cloud''?', 'Data stored on remote servers accessed over the internet.', 21),
  (d_id, 'What is a protocol?', 'A set of rules for communication (e.g. TCP/IP, HTTP).', 22);

  -- GCSE Maths - Number (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Maths - Number (Y10)', 'SYLLABUS: Standard form, surds, indices, rounding, bounds', 'Mathematics', 10, 23, 24, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a surd?', 'An irrational root that cannot be simplified to a whole number (e.g. √2, √3).', 0),
  (d_id, 'Simplify √12.', '2√3 (√(4x3) = 2√3).', 1),
  (d_id, 'Rationalise 1/√2.', '√2/2 (multiply top and bottom by √2).', 2),
  (d_id, 'Write 5.6 x 10⁻⁴ as an ordinary number.', '0.00056.', 3),
  (d_id, 'Write 0.00008 in standard form.', '8 x 10⁻⁵.', 4),
  (d_id, 'Write 4,000,000 in standard form.', '4 x 10⁶.', 5),
  (d_id, 'Simplify (2x³)².', '4x⁶.', 6),
  (d_id, 'What is 8^(2/3)?', '4 (cube root of 8 is 2, squared is 4).', 7),
  (d_id, 'What does x^(1/2) equal?', '√x.', 8),
  (d_id, 'What is 10^5 x 10^-2?', '10³.', 9),
  (d_id, 'Round 4.567 to 2 significant figures.', '4.6.', 10),
  (d_id, 'Round 0.00349 to 2 significant figures.', '0.0035.', 11),
  (d_id, 'What is the upper bound of 5.3 rounded to 1 dp?', '5.35.', 12),
  (d_id, 'What is the lower bound of 5.3 rounded to 1 dp?', '5.25.', 13),
  (d_id, 'What is a recurring decimal?', 'A decimal with a repeating digit (e.g. 1/3 = 0.333...).', 14),
  (d_id, 'Write 0.444... as a fraction.', '4/9 (let x = 0.444..., 10x = 4.444..., 9x = 4).', 15),
  (d_id, 'What is the highest common factor of 24 and 36?', '12.', 16),
  (d_id, 'What is the lowest common multiple of 8 and 12?', '24.', 17),
  (d_id, 'What is the product of prime factors of 12?', '2² x 3.', 18),
  (d_id, 'What is 17% as a decimal?', '0.17.', 19),
  (d_id, 'What is a ratio expressed as ''1:n'' example: 20:5?', '1:0.25 (or 1:1/4).', 20),
  (d_id, 'Increase 300 by 18%.', '354 (multiply by 1.18).', 21),
  (d_id, 'What is the multiplier for a 6% decrease?', '0.94.', 22);

  -- GCSE Maths - Algebra (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Maths - Algebra (Y10)', 'SYLLABUS: Quadratics, simultaneous equations, inequalities, sequences', 'Mathematics', 10, 23, 50, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Solve x² + 6x + 9 = 0.', 'x = -3 (repeated root; it is (x+3)²).', 0),
  (d_id, 'Solve x² - 5x = 0.', 'x = 0 or x = 5 (factorise x(x - 5)).', 1),
  (d_id, 'What does completing the square give for x² + 6x + 2?', '(x + 3)² - 7.', 2),
  (d_id, 'Solve the simultaneous equations x + y = 10 and x - y = 4.', 'x = 7, y = 3 (add the equations).', 3),
  (d_id, 'Solve 2x + y = 7 and x - y = 2.', 'x = 3, y = 1.', 4),
  (d_id, 'What does ''elimination'' mean in simultaneous equations?', 'Adding or subtracting equations to remove one variable.', 5),
  (d_id, 'Solve x² + y² = 25 and y = x + 1 (integer solutions).', 'x = 3, y = 4 (or x = -4, y = -3).', 6),
  (d_id, 'What are the solutions of 3(x + 2) ≤ 15?', 'x ≤ 3.', 7),
  (d_id, 'Solve 2x - 1 > 9.', 'x > 5.', 8),
  (d_id, 'What is the nth term of 4, 9, 16, 25?', 'n² + 2n + 1 = (n + 1)².', 9),
  (d_id, 'What is the nth term of 1, 3, 6, 10 (triangular)?', 'n(n + 1)/2.', 10),
  (d_id, 'Find the 20th term of 3n - 4.', '56.', 11),
  (d_id, 'What is a quadratic sequence?', 'A sequence with a constant second difference.', 12),
  (d_id, 'What is the second difference of n²?', '2 (constant).', 13),
  (d_id, 'Factorise 2x² + 7x + 3.', '(2x + 1)(x + 3).', 14),
  (d_id, 'What is the turning point of y = (x - 2)² + 5?', '(2, 5).', 15),
  (d_id, 'What is the discriminant of x² + 4x + 5?', 'b² - 4ac = 16 - 20 = -4 (no real roots).', 16),
  (d_id, 'Solve 3x² = 75.', 'x = ±5.', 17),
  (d_id, 'What is an identity?', 'An equation true for all values (e.g. (x+1)² ≡ x² + 2x + 1).', 18),
  (d_id, 'Rearrange v = u + at to make a the subject.', 'a = (v - u)/t.', 19),
  (d_id, 'Rearrange A = ½bh to make h the subject.', 'h = 2A/b.', 20),
  (d_id, 'What is the gradient of a line perpendicular to y = 2x + 3?', '-1/2 (perpendicular gradients multiply to -1).', 21),
  (d_id, 'What is the equation of a line parallel to y = 3x + 1 through (0, 5)?', 'y = 3x + 5.', 22);

  -- GCSE Biology - Topic 1: Cell Biology (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Biology - Topic 1: Cell Biology (Y10)', 'SYLLABUS: Cell structure, transport in cells, cell division, stem cells', 'Biology', 10, 23, 50, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the parts of an animal cell?', 'Nucleus, cytoplasm, cell membrane, mitochondria, ribosomes.', 0),
  (d_id, 'What extra parts do plant cells have?', 'Cell wall, chloroplasts, permanent vacuole.', 1),
  (d_id, 'What does the mitochondria do?', 'Site of aerobic respiration, releasing energy.', 2),
  (d_id, 'What do ribosomes do?', 'Synthesise proteins.', 3),
  (d_id, 'What is the function of the cell membrane?', 'Controls what enters and leaves the cell.', 4),
  (d_id, 'What is differentiation?', 'Cells becoming specialised for a function.', 5),
  (d_id, 'What is a specialised cell example?', 'Sperm cell (flagellum), root hair cell (large surface area), red blood cell (biconcave).', 6),
  (d_id, 'What is diffusion?', 'Net movement of particles from high to low concentration.', 7),
  (d_id, 'What affects the rate of diffusion?', 'Concentration gradient, temperature, surface area.', 8),
  (d_id, 'What is osmosis?', 'Movement of water across a partially permeable membrane from high water potential to low.', 9),
  (d_id, 'What happens to a plant cell in pure water?', 'It becomes turgid (swells but cell wall prevents bursting).', 10),
  (d_id, 'What happens to an animal cell in pure water?', 'It bursts (no cell wall).', 11),
  (d_id, 'What is active transport?', 'Movement from low to high concentration, using energy from respiration.', 12),
  (d_id, 'Where does active transport happen in the body?', 'In the gut (absorbing glucose) and root hair cells (absorbing minerals).', 13),
  (d_id, 'What is the cell cycle?', 'Cell growth, DNA replication, then mitosis (division into two).', 14),
  (d_id, 'What is mitosis used for?', 'Growth and repair; produces two identical diploid cells.', 15),
  (d_id, 'What is the difference between mitosis and meiosis?', 'Mitosis = 2 identical cells (growth); meiosis = 4 different haploid gametes.', 16),
  (d_id, 'What is a stem cell?', 'An undifferentiated cell that can become different cell types.', 17),
  (d_id, 'Where are stem cells found in adults?', 'Bone marrow.', 18),
  (d_id, 'What are the uses of stem cells?', 'Treating diseases (e.g. diabetes, paralysis) and plant cloning.', 19),
  (d_id, 'What is a drawback of using embryonic stem cells?', 'Ethical concerns about destroying embryos.', 20),
  (d_id, 'What is a meristem?', 'Plant tissue containing stem cells for growth.', 21),
  (d_id, 'How do you calculate magnification?', 'magnification = image size / actual size.', 22);

  -- GCSE Biology - Topic 2: Organisation (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Biology - Topic 2: Organisation (Y10)', 'SYLLABUS: Enzymes, digestion, lungs, blood, plant transport', 'Biology', 10, 25, 52, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a tissue?', 'A group of similar cells performing a function.', 0),
  (d_id, 'What is an organ?', 'A group of tissues working together (e.g. stomach).', 1),
  (d_id, 'What is an enzyme?', 'A biological catalyst that speeds up reactions.', 2),
  (d_id, 'What is the ''lock and key'' model?', 'Substrate fits the enzyme''s active site, which is specific.', 3),
  (d_id, 'What happens to enzymes at high temperature?', 'They denature (active site changes shape; no longer works).', 4),
  (d_id, 'What is the optimum pH for most enzymes?', 'Around pH 7 (neutral).', 5),
  (d_id, 'What is the optimum pH for pepsin?', 'Acidic (pH 2, in the stomach).', 6),
  (d_id, 'What does amylase do?', 'Breaks starch into sugars.', 7),
  (d_id, 'What does protease do?', 'Breaks proteins into amino acids.', 8),
  (d_id, 'What does lipase do?', 'Breaks lipids into fatty acids and glycerol.', 9),
  (d_id, 'Where is bile made and stored?', 'Made in the liver, stored in the gall bladder.', 10),
  (d_id, 'What does bile do?', 'Emulsifies fats and neutralises stomach acid.', 11),
  (d_id, 'What is the order of the digestive system?', 'Mouth, oesophagus, stomach, small intestine, large intestine, rectum.', 12),
  (d_id, 'Where is most digestion and absorption?', 'The small intestine.', 13),
  (d_id, 'What are villi?', 'Finger-like projections in the small intestine increasing surface area.', 14),
  (d_id, 'What are the lungs'' gas exchange surfaces?', 'Alveoli - tiny air sacs with a large surface area.', 15),
  (d_id, 'How is oxygen transported in the blood?', 'Bound to haemoglobin in red blood cells.', 16),
  (d_id, 'What are the components of blood?', 'Red blood cells, white blood cells, platelets, plasma.', 17),
  (d_id, 'What do white blood cells do?', 'Fight infection (phagocytosis and antibody production).', 18),
  (d_id, 'What are platelets?', 'Cell fragments that clot the blood.', 19),
  (d_id, 'What is the function of the coronary arteries?', 'Supply blood to the heart muscle.', 20),
  (d_id, 'What is the function of xylem?', 'Transports water and minerals up from the roots.', 21),
  (d_id, 'What is the function of phloem?', 'Transports sugars around the plant (translocation).', 22),
  (d_id, 'What is transpiration?', 'Loss of water vapour from leaves, pulling water up the xylem.', 23),
  (d_id, 'What increases transpiration rate?', 'Higher temperature, wind, and light intensity.', 24);

  -- GCSE Chemistry - Topic 1: Atomic Structure (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Chemistry - Topic 1: Atomic Structure (Y10)', 'SYLLABUS: Atoms, isotopes, electron configuration, periodic table, history', 'Chemistry', 10, 24, 57, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the three subatomic particles?', 'Proton (+), neutron (0), electron (-).', 0),
  (d_id, 'Where are protons and neutrons?', 'In the nucleus.', 1),
  (d_id, 'What is the relative mass of an electron?', 'Negligible (about 1/1840).', 2),
  (d_id, 'What is the atomic number?', 'The number of protons (and electrons).', 3),
  (d_id, 'What is the mass number?', 'Protons + neutrons.', 4),
  (d_id, 'What are isotopes?', 'Atoms of the same element with different numbers of neutrons.', 5),
  (d_id, 'Write the electron configuration of sodium (11).', '2, 8, 1.', 6),
  (d_id, 'Write the electron configuration of chlorine (17).', '2, 8, 7.', 7),
  (d_id, 'Write the electron configuration of calcium (20).', '2, 8, 8, 2.', 8),
  (d_id, 'How many electrons fit in the first shell?', '2.', 9),
  (d_id, 'How many in the second shell?', '8.', 10),
  (d_id, 'Who organised the first periodic table?', 'Dmitri Mendeleev (1869).', 11),
  (d_id, 'Why did Mendeleev leave gaps?', 'For undiscovered elements, predicted by their properties.', 12),
  (d_id, 'Why are elements in the same group similar?', 'Same number of outer electrons.', 13),
  (d_id, 'What are elements in Group 1 called?', 'Alkali metals.', 14),
  (d_id, 'What are elements in Group 7 called?', 'Halogens.', 15),
  (d_id, 'What are elements in Group 0 called?', 'Noble gases (unreactive, full outer shell).', 16),
  (d_id, 'Why are noble gases unreactive?', 'They have a full outer shell of electrons.', 17),
  (d_id, 'What is a compound?', 'Two or more elements chemically combined in fixed proportions.', 18),
  (d_id, 'What is a mixture?', 'Substances that can be separated by physical methods.', 19),
  (d_id, 'What is an ion?', 'An atom that has gained or lost electrons (charged).', 20),
  (d_id, 'How is a sodium ion formed?', 'Sodium loses one electron to become Na+.', 21),
  (d_id, 'How is a chloride ion formed?', 'Chlorine gains one electron to become Cl-.', 22),
  (d_id, 'What is the mass number of carbon-12?', '12 (6 protons + 6 neutrons).', 23);

  -- GCSE Chemistry - Topic 2: Bonding (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Chemistry - Topic 2: Bonding (Y10)', 'SYLLABUS: Ionic, covalent, metallic bonding; structures and properties', 'Chemistry', 10, 23, 32, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is ionic bonding?', 'Transfer of electrons between a metal and a non-metal, forming ions.', 0),
  (d_id, 'What is the structure of an ionic compound?', 'A giant lattice of oppositely charged ions.', 1),
  (d_id, 'Why do ionic compounds have high melting points?', 'Strong electrostatic forces hold the giant lattice.', 2),
  (d_id, 'Why do ionic compounds conduct when molten/dissolved?', 'Ions are free to move and carry charge.', 3),
  (d_id, 'What is covalent bonding?', 'Sharing of electron pairs between non-metals.', 4),
  (d_id, 'Give an example of a simple covalent molecule.', 'H2O, CO2, CH4, O2.', 5),
  (d_id, 'Why do simple covalent molecules have low melting points?', 'Weak intermolecular forces between molecules.', 6),
  (d_id, 'Do simple molecules conduct electricity?', 'No - they have no free ions or electrons.', 7),
  (d_id, 'What is a giant covalent structure?', 'Millions of atoms bonded in a huge lattice (e.g. diamond, graphite, silicon dioxide).', 8),
  (d_id, 'Why does diamond have a high melting point?', 'Many strong covalent bonds across the whole structure.', 9),
  (d_id, 'Why doesn''t diamond conduct electricity?', 'All four outer electrons are bonded; no free electrons.', 10),
  (d_id, 'Why does graphite conduct electricity?', 'One free (delocalised) electron per carbon allows conduction.', 11),
  (d_id, 'Why is graphite soft?', 'Layers can slide over each other (weak forces between layers).', 12),
  (d_id, 'What is graphene?', 'A single layer of graphite, strong and conductive.', 13),
  (d_id, 'What is metallic bonding?', 'Positive ions in a ''sea'' of delocalised electrons.', 14),
  (d_id, 'Why do metals conduct electricity?', 'Delocalised electrons move freely.', 15),
  (d_id, 'Why are metals malleable?', 'Layers of ions can slide without breaking bonds.', 16),
  (d_id, 'What is an alloy?', 'A mixture of metals (or metal + non-metal) that is harder than pure metals.', 17),
  (d_id, 'Why are alloys harder?', 'Different sized atoms distort the layers.', 18),
  (d_id, 'What is a polymer?', 'Long chains of repeating monomers joined by covalent bonds.', 19),
  (d_id, 'What is a fullerene?', 'A hollow carbon molecule (e.g. C60 buckyball), used in medicine and lubricants.', 20),
  (d_id, 'What is a nanoparticle?', 'A particle 1-100 nm, with high surface area to volume ratio.', 21),
  (d_id, 'Give a use of nanoparticles.', 'Catalysts, sunscreens, medicines, sensors.', 22);

  -- GCSE Physics - Topic 1: Energy (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Physics - Topic 1: Energy (Y10)', 'SYLLABUS: Energy stores, transfers, kinetic, GPE, power, efficiency', 'Physics', 10, 22, 53, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Name the energy stores.', 'Kinetic, gravitational potential, elastic potential, thermal, chemical, nuclear, magnetic, electrostatic.', 0),
  (d_id, 'What is the equation for kinetic energy?', 'KE = ½ x mass x speed² (J).', 1),
  (d_id, 'What is the equation for gravitational potential energy?', 'GPE = mass x gravitational field strength x height.', 2),
  (d_id, 'On Earth, what is gravitational field strength?', '10 N/kg.', 3),
  (d_id, 'Calculate GPE of 5kg at 3m (g=10).', '150 J.', 4),
  (d_id, 'Calculate KE of 4kg moving at 3 m/s.', '18 J (½ x 4 x 9).', 5),
  (d_id, 'What is elastic potential energy?', 'Energy stored when an object is stretched or compressed.', 6),
  (d_id, 'What is specific heat capacity?', 'The energy to raise 1kg of a substance by 1°C (J/kg°C).', 7),
  (d_id, 'What is the specific heat capacity equation?', 'E = mass x specific heat capacity x temperature change.', 8),
  (d_id, 'What is power?', 'The rate of energy transfer (power = energy/time).', 9),
  (d_id, 'What is the unit of power?', 'Watt (W), which is J/s.', 10),
  (d_id, 'Calculate power if 300J is transferred in 5s.', '60 W.', 11),
  (d_id, 'What is efficiency?', '(useful output / total input) x 100%.', 12),
  (d_id, 'A bulb uses 100J, gives 30J of light. Efficiency?', '30%.', 13),
  (d_id, 'What happens to ''lost'' energy?', 'It spreads out (dissipated) to the surroundings as heat.', 14),
  (d_id, 'What is a renewable energy resource?', 'One that replenishes (solar, wind, hydro, geothermal, tidal, biomass).', 15),
  (d_id, 'What is a non-renewable energy resource?', 'One that will run out (fossil fuels, nuclear).', 16),
  (d_id, 'What is the environmental impact of burning fossil fuels?', 'CO2 (global warming) and other pollutants.', 17),
  (d_id, 'What is nuclear energy?', 'Energy from splitting atoms (fission), no CO2 but radioactive waste.', 18),
  (d_id, 'What is thermal insulation?', 'Reducing unwanted heat loss using insulators and layers.', 19),
  (d_id, 'How does loft insulation reduce heat loss?', 'Traps air (a good insulator) to slow conduction/convection.', 20),
  (d_id, 'What is a Sankey diagram?', 'A diagram showing energy input, useful output, and wasted energy.', 21);

  -- GCSE Physics - Topic 2: Electricity (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Physics - Topic 2: Electricity (Y10)', 'SYLLABUS: Circuits, current, voltage, resistance, components, national grid', 'Physics', 10, 23, 58, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is electric current?', 'The rate of flow of charge, measured in amps (A).', 0),
  (d_id, 'What is voltage (potential difference)?', 'The energy transferred per unit charge, measured in volts (V).', 1),
  (d_id, 'What is resistance?', 'The opposition to current, measured in ohms (Ω).', 2),
  (d_id, 'State Ohm''s law.', 'V = I x R.', 3),
  (d_id, 'Calculate current with V=12V, R=4Ω.', 'I = 3 A.', 4),
  (d_id, 'What is the resistance of a wire proportional to?', 'Its length (double length = double resistance).', 5),
  (d_id, 'In a series circuit, what is the total resistance?', 'The sum of the resistances (R = R1 + R2).', 6),
  (d_id, 'What is current like in a series circuit?', 'The same everywhere.', 7),
  (d_id, 'What is voltage like in a series circuit?', 'Shared between components.', 8),
  (d_id, 'What is voltage like in a parallel circuit?', 'Same across each branch.', 9),
  (d_id, 'What is current like in a parallel circuit?', 'Splits between branches (total = sum of branch currents).', 10),
  (d_id, 'What happens if one component fails in series?', 'The whole circuit stops.', 11),
  (d_id, 'What happens if one component fails in parallel?', 'Other branches keep working.', 12),
  (d_id, 'What is an LDR?', 'Light Dependent Resistor - resistance falls as light increases.', 13),
  (d_id, 'What is a thermistor?', 'Temperature-dependent resistor - resistance falls as temperature rises.', 14),
  (d_id, 'What is AC current?', 'Alternating current - changes direction (mains 50 Hz).', 15),
  (d_id, 'What is DC current?', 'Direct current - flows one way (from batteries).', 16),
  (d_id, 'What is the UK mains voltage?', '230 V.', 17),
  (d_id, 'What does a fuse do?', 'Melts and breaks the circuit if current is too high.', 18),
  (d_id, 'What is the earth wire for?', 'Protects against electric shock if a live wire touches the case.', 19),
  (d_id, 'What is the national grid?', 'The network of cables and transformers delivering electricity.', 20),
  (d_id, 'Why step up the voltage for transmission?', 'Higher voltage = lower current = less energy lost as heat.', 21),
  (d_id, 'What is a step-up transformer used for?', 'Increasing voltage for efficient transmission.', 22);

  -- GCSE English Literature - Macbeth (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE English Literature - Macbeth (Y10)', 'SYLLABUS: Macbeth: characters, themes, key quotes, context', 'English', 10, 24, 53, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who wrote Macbeth?', 'William Shakespeare (c. 1606).', 0),
  (d_id, 'Who was Macbeth''s wife?', 'Lady Macbeth.', 1),
  (d_id, 'What is the play''s main theme?', 'Ambition (and its corrupting power), plus guilt, fate, and power.', 2),
  (d_id, 'Who are the three witches?', 'The Weird Sisters who prophesy Macbeth''s future.', 3),
  (d_id, 'What prophecy do they give Macbeth?', 'He will be Thane of Cawdor, then King of Scotland.', 4),
  (d_id, 'Who is Banquo?', 'Macbeth''s friend and fellow general; his heirs are prophesied to be kings.', 5),
  (d_id, 'Who is Duncan?', 'The King of Scotland, murdered by Macbeth.', 6),
  (d_id, 'Who is Macduff?', 'The nobleman who eventually kills Macbeth.', 7),
  (d_id, 'What does ''Fair is foul, and foul is fair'' suggest?', 'Nothing is as it seems; moral confusion.', 8),
  (d_id, 'What does Lady Macbeth call on in her soliloquy?', 'Spirits to ''unsex'' her and fill her with cruelty.', 9),
  (d_id, 'What does ''Come, you spirits... unsex me here'' show?', 'Her rejection of femininity for power.', 10),
  (d_id, 'What is the significance of blood imagery?', 'Represents guilt - ''Will all great Neptune''s ocean wash this blood clean?''.', 11),
  (d_id, 'What does ''Is this a dagger which I see before me'' show?', 'Macbeth''s guilty hallucination before the murder.', 12),
  (d_id, 'What does ''Out, damned spot'' reveal about Lady Macbeth?', 'Her guilt manifests in sleepwalking.', 13),
  (d_id, 'What does ''I have no spur to prick the sides of my intent'' show?', 'His ambition lacks justification.', 14),
  (d_id, 'Who does Macbeth kill first?', 'King Duncan.', 15),
  (d_id, 'Who does Macbeth then order killed?', 'Banquo (and tries to kill his son Fleance).', 16),
  (d_id, 'What happens to Lady Macbeth?', 'She dies, likely by suicide, consumed by guilt.', 17),
  (d_id, 'How does Macbeth die?', 'Killed by Macduff in the final battle.', 18),
  (d_id, 'What is a tragic hero?', 'A noble character whose fatal flaw (hubris/ambition) leads to their downfall.', 19),
  (d_id, 'What is Macbeth''s fatal flaw?', 'Unchecked ambition.', 20),
  (d_id, 'What does the dagger point to?', 'Duncan''s chamber - symbol of his murderous intent.', 21),
  (d_id, 'What is dramatic irony?', 'When the audience knows more than the characters (e.g. ''he was a gentleman on whom I built an absolute trust'').', 22),
  (d_id, 'How is Lady Macbeth presented as powerful?', 'She manipulates Macbeth, challenging his masculinity (''When you durst do it, then you were a man'').', 23);

  -- GCSE English Literature - An Inspector Calls (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE English Literature - An Inspector Calls (Y10)', 'SYLLABUS: J.B. Priestley: characters, themes, key quotes, context', 'English', 10, 25, 32, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who wrote An Inspector Calls?', 'J.B. Priestley (1945, set in 1912).', 0),
  (d_id, 'Who is the Inspector?', 'Inspector Goole - possibly supernatural, his name suggests ''ghoul''.', 1),
  (d_id, 'What is the Birling family''s business?', 'They own a factory.', 2),
  (d_id, 'Who is Eva Smith?', 'The young woman who died; the family all contributed to her downfall.', 3),
  (d_id, 'Why does the Inspector interrogate each character?', 'To show collective responsibility for Eva''s death.', 4),
  (d_id, 'Who is Arthur Birling?', 'The head of the family, capitalist, dismissive of responsibility.', 5),
  (d_id, 'What is Arthur Birling''s famous quote about society?', '''A man has to make his own way - look after himself''.', 6),
  (d_id, 'Who is Sheila Birling?', 'Birling''s daughter, who got Eva fired from Milwards.', 7),
  (d_id, 'What does Sheila say about responsibility?', '''I know I''m to blame'' - she accepts responsibility and changes.', 8),
  (d_id, 'Who is Eric Birling?', 'Birling''s son, who got Eva pregnant and stole money.', 9),
  (d_id, 'Who is Sybil Birling?', 'Mrs Birling, who refused Eva help at her charity.', 10),
  (d_id, 'Who is Gerald Croft?', 'Sheila''s fiancé who had an affair with Eva (''Daisy Renton'').', 11),
  (d_id, 'What does Eva/Daisy''s many names suggest?', 'She represents any ordinary working woman, not just one person.', 12),
  (d_id, 'What is the main theme?', 'Social responsibility and class.', 13),
  (d_id, 'What is the Inspector''s key message?', '''We are members of one body. We are responsible for each other''.', 14),
  (d_id, 'What does ''They will be taught it in fire and blood and anguish'' foreshadow?', 'Both world wars.', 15),
  (d_id, 'What is Priestley''s political message?', 'A call for socialism and collective responsibility.', 16),
  (d_id, 'Why is the play set in 1912?', 'Before WWI, to show that capitalism leads to catastrophe.', 17),
  (d_id, 'Why was it written in 1945?', 'After WWII, to promote a new socialist society.', 18),
  (d_id, 'What does the ''telephone call'' at the end reveal?', 'A real Inspector is coming - the message continues.', 19),
  (d_id, 'What is the structure of the play?', 'A three-act play with dramatic irony and a cyclical ending.', 20),
  (d_id, 'What is the Inspector a mouthpiece for?', 'Priestley''s socialist views.', 21),
  (d_id, 'How does Sheila develop?', 'From naïve girl to morally responsible adult.', 22),
  (d_id, 'What is the significance of the ending?', 'It repeats the cycle, suggesting society must still change.', 23),
  (d_id, 'What is the ''one body'' metaphor?', 'Society is interdependent; harming one harms all.', 24);

  -- GCSE English Language - Paper 1 & 2 Skills (Y10)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE English Language - Paper 1 & 2 Skills (Y10)', 'SYLLABUS: Exam technique for AQA English Language papers', 'English', 10, 24, 34, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'How long is English Language Paper 1?', '1 hour 45 minutes, 80 marks.', 0),
  (d_id, 'What does Paper 1 assess?', 'Reading (fiction) and writing (descriptive/narrative).', 1),
  (d_id, 'What does Paper 2 assess?', 'Reading (non-fiction) and writing (transactional - speeches, articles, letters).', 2),
  (d_id, 'What is Q1 on Paper 1?', 'List 4 things from the source (4 marks, 4 minutes).', 3),
  (d_id, 'What is Q2 on Paper 1?', 'How does the writer use language? (8 marks).', 4),
  (d_id, 'What is Q3 on Paper 1?', 'How does the writer structure the text? (8 marks).', 5),
  (d_id, 'What is Q4 on Paper 1?', 'Evaluate a statement about the text (20 marks).', 6),
  (d_id, 'What is Q5 on Paper 1?', 'Creative writing: description or narrative (40 marks).', 7),
  (d_id, 'What is Q2 on Paper 2?', 'Summarise differences between two sources.', 8),
  (d_id, 'What is Q4 on Paper 2?', 'Compare writers'' viewpoints (16 marks).', 9),
  (d_id, 'What is Q5 on Paper 2?', 'Transactional writing (speech, article, letter, leaflet).', 10),
  (d_id, 'What should language analysis include?', 'A quote, a method (technique), and an effect (what it makes the reader think/feel).', 11),
  (d_id, 'What is a technique in Q2?', 'Metaphor, simile, personification, imagery, verbs, adjectives, adverbs.', 12),
  (d_id, 'What is structural analysis about?', 'Focus, shift, contrast, repetition, zooming in/out, cyclic structure.', 13),
  (d_id, 'What is the ''PEEL'' paragraph structure?', 'Point, Evidence, Explanation, Link.', 14),
  (d_id, 'What should you always link to in analysis?', 'The writer''s purpose and the reader''s response.', 15),
  (d_id, 'How many paragraphs for Q5?', '5-6: opening, 3-4 developed, closing.', 16),
  (d_id, 'What should creative writing include?', 'Sensory language, varied sentences, ambitious vocabulary, a clear structure.', 17),
  (d_id, 'What should transactional writing include?', 'A clear viewpoint, persuasive techniques, audience awareness, rhetorical devices.', 18),
  (d_id, 'What is a rhetorical question?', 'A question not needing an answer, to persuade/involve the reader.', 19),
  (d_id, 'What is AFOREST?', 'Alliteration, Facts, Opinions, Rhetorical questions, Emotive language, Statistics, Triplets.', 20),
  (d_id, 'Why should you plan before writing?', 'To organise ideas and ensure a coherent structure.', 21),
  (d_id, 'How much time for reading?', '10-15 minutes reading and annotating.', 22),
  (d_id, 'What is ''context'' used for in Language papers?', 'To link to the writer''s purpose, not external facts (unlike Literature).', 23);

  -- GCSE Maths - Geometry & Trigonometry (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Maths - Geometry & Trigonometry (Y11)', 'SYLLABUS: Circle theorems, bearings, sine/cosine rules, vectors', 'Mathematics', 11, 24, 31, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the angle at the centre theorem?', 'The angle at the centre is twice the angle at the circumference.', 0),
  (d_id, 'What is the angle in a semicircle?', '90 degrees.', 1),
  (d_id, 'What are angles in the same segment?', 'They are equal.', 2),
  (d_id, 'What is the angle between a tangent and radius?', '90 degrees.', 3),
  (d_id, 'What is the alternate segment theorem?', 'The angle between a tangent and chord equals the angle in the alternate segment.', 4),
  (d_id, 'What is the bearing of East?', '090°.', 5),
  (d_id, 'What is the bearing of South?', '180°.', 6),
  (d_id, 'What is the bearing of North-West?', '315°.', 7),
  (d_id, 'What is the sine rule?', 'a/sinA = b/sinB = c/sinC.', 8),
  (d_id, 'What is the cosine rule?', 'a² = b² + c² - 2bc cosA.', 9),
  (d_id, 'When do you use the sine rule?', 'To find a side/angle with a matching pair (angle and opposite side).', 10),
  (d_id, 'When do you use the cosine rule?', 'Two sides and the included angle, or three sides.', 11),
  (d_id, 'What is the formula for the area of a non-right triangle?', 'Area = ½ ab sinC.', 12),
  (d_id, 'What is a vector?', 'A quantity with magnitude and direction, e.g. (3, 2).', 13),
  (d_id, 'How do you add vectors?', 'Add corresponding components.', 14),
  (d_id, 'What is the magnitude of vector (3, 4)?', '5 (Pythagoras).', 15),
  (d_id, 'What is a unit vector?', 'A vector of magnitude 1.', 16),
  (d_id, 'What is a column vector for ''3 right, 2 up''?', '(3, 2) written vertically.', 17),
  (d_id, 'What are scalar multiples of vectors?', 'Multiplying a vector by a number changes magnitude, not direction.', 18),
  (d_id, 'What is the equation of a circle centre (0,0) radius 5?', 'x² + y² = 25.', 19),
  (d_id, 'What is the volume of a sphere?', '4/3 π r³.', 20),
  (d_id, 'What is the surface area of a sphere?', '4π r².', 21),
  (d_id, 'What is the volume of a cone?', '1/3 π r² h.', 22),
  (d_id, 'What is the volume of a cylinder?', 'π r² h.', 23);

  -- GCSE Maths - Statistics & Probability (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Maths - Statistics & Probability (Y11)', 'SYLLABUS: Averages, cumulative frequency, histograms, probability', 'Mathematics', 11, 23, 20, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the mode?', 'The most common value.', 0),
  (d_id, 'What is the median?', 'The middle value when data is ordered.', 1),
  (d_id, 'What is the mean?', 'Sum of values divided by the number of values.', 2),
  (d_id, 'What is the range?', 'Highest minus lowest.', 3),
  (d_id, 'Find the median of 3, 7, 1, 9, 5.', '5 (order: 1, 3, 5, 7, 9).', 4),
  (d_id, 'What is the interquartile range?', 'Upper quartile - lower quartile (middle 50%).', 5),
  (d_id, 'What is the mean of 4, 6, 8, 10?', '7.', 6),
  (d_id, 'What is cumulative frequency?', 'The running total of frequencies.', 7),
  (d_id, 'What can you read from a cumulative frequency graph?', 'Median, quartiles, and interquartile range.', 8),
  (d_id, 'What does a box plot show?', 'Minimum, lower quartile, median, upper quartile, maximum.', 9),
  (d_id, 'What is probability of an impossible event?', '0.', 10),
  (d_id, 'What is probability of a certain event?', '1.', 11),
  (d_id, 'Two dice are rolled; probability of a total of 7?', '6/36 = 1/6.', 12),
  (d_id, 'What is the probability of an event not happening?', '1 - P(event).', 13),
  (d_id, 'What is relative frequency?', 'Number of times event occurs / number of trials (experimental probability).', 14),
  (d_id, 'What is a probability tree diagram used for?', 'Showing outcomes of sequential events (multiply along branches).', 15),
  (d_id, 'What is the AND rule?', 'P(A and B) = P(A) x P(B) for independent events.', 16),
  (d_id, 'What is the OR rule?', 'P(A or B) = P(A) + P(B) for mutually exclusive events.', 17),
  (d_id, 'What are mutually exclusive events?', 'Events that cannot happen together (e.g. heads/tails).', 18),
  (d_id, 'What is a histogram?', 'A bar chart for continuous data where area = frequency.', 19),
  (d_id, 'What is a frequency polygon?', 'A line graph joining midpoints of frequency bars.', 20),
  (d_id, 'What is the mean of a frequency table?', 'Sum of (value x frequency) / total frequency.', 21),
  (d_id, 'What is sampling?', 'Choosing a subset of a population to represent the whole.', 22);

  -- GCSE Biology - Topic 4 & 5: Bioenergetics & Homeostasis (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Biology - Topic 4 & 5: Bioenergetics & Homeostasis (Y11)', 'SYLLABUS: Photosynthesis, respiration, homeostasis, hormones, the brain', 'Biology', 11, 24, 37, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the word equation for photosynthesis?', 'Carbon dioxide + water -> (light, chlorophyll) glucose + oxygen.', 0),
  (d_id, 'Where does photosynthesis happen?', 'In the chloroplasts.', 1),
  (d_id, 'What is the chemical equation for photosynthesis?', '6CO2 + 6H2O -> C6H12O6 + 6O2.', 2),
  (d_id, 'What factors limit photosynthesis?', 'Light intensity, CO2 concentration, and temperature.', 3),
  (d_id, 'What is the inverse square law for light intensity?', 'Light intensity ∝ 1/d².', 4),
  (d_id, 'How do plants use glucose?', 'Respiration, making cellulose, amino acids, stored as starch, fats/oils.', 5),
  (d_id, 'What is aerobic respiration?', 'Glucose + oxygen -> carbon dioxide + water (releases energy).', 6),
  (d_id, 'Where does aerobic respiration happen?', 'In the mitochondria.', 7),
  (d_id, 'What is anaerobic respiration in animals?', 'Glucose -> lactic acid (releases energy without oxygen).', 8),
  (d_id, 'Why is anaerobic respiration less efficient?', 'It releases much less energy per glucose.', 9),
  (d_id, 'What is oxygen debt?', 'The extra oxygen needed to break down lactic acid after exercise.', 10),
  (d_id, 'What is anaerobic respiration in plants/yeast?', 'Glucose -> ethanol + carbon dioxide (fermentation).', 11),
  (d_id, 'What is homeostasis?', 'Maintaining a stable internal environment.', 12),
  (d_id, 'What does the body control in homeostasis?', 'Blood glucose, body temperature, water levels.', 13),
  (d_id, 'How does the body control temperature?', 'Sweating, shivering, vasodilation/constriction, hair erector muscles.', 14),
  (d_id, 'What is insulin?', 'A hormone lowering blood glucose by storing glucose as glycogen.', 15),
  (d_id, 'What is glucagon?', 'A hormone raising blood glucose by converting glycogen back to glucose.', 16),
  (d_id, 'What is Type 1 diabetes?', 'The pancreas produces little/no insulin; treated with insulin injections.', 17),
  (d_id, 'What is Type 2 diabetes?', 'Body cells become resistant to insulin; linked to obesity.', 18),
  (d_id, 'What is the endocrine system?', 'Glands producing hormones carried in the blood to target organs.', 19),
  (d_id, 'What is the pituitary gland?', 'The ''master gland'' controlling other glands.', 20),
  (d_id, 'What hormones control the menstrual cycle?', 'FSH, LH, oestrogen, and progesterone.', 21),
  (d_id, 'What is the role of the kidneys?', 'Filtering blood, removing urea and excess water.', 22),
  (d_id, 'What is ADH?', 'Anti-diuretic hormone controlling water reabsorption in the kidneys.', 23);

  -- GCSE Biology - Topic 6 & 7: Inheritance & Ecology (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Biology - Topic 6 & 7: Inheritance & Ecology (Y11)', 'SYLLABUS: Inheritance, evolution, ecology, food chains, carbon cycle', 'Biology', 11, 25, 40, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a gamete?', 'A sex cell (sperm, egg, pollen) with half the chromosomes.', 0),
  (d_id, 'How many chromosomes do humans have?', '46 (23 pairs).', 1),
  (d_id, 'What is the sex chromosome for a male?', 'XY.', 2),
  (d_id, 'What is the sex chromosome for a female?', 'XX.', 3),
  (d_id, 'What is a dominant allele?', 'Expressed even with one copy (capital letter).', 4),
  (d_id, 'What is a recessive allele?', 'Only expressed with two copies (lowercase).', 5),
  (d_id, 'What is a Punnett square?', 'A grid showing possible offspring genotypes.', 6),
  (d_id, 'What is the probability of a child being male?', '50% (1 in 2).', 7),
  (d_id, 'What is a mutation?', 'A change in DNA that can create new alleles.', 8),
  (d_id, 'What is natural selection?', 'Organisms best adapted to their environment survive and reproduce.', 9),
  (d_id, 'What is evolution?', 'The change in inherited characteristics of a species over generations.', 10),
  (d_id, 'What evidence supports evolution?', 'Fossils, antibiotic resistance, Darwin''s finches.', 11),
  (d_id, 'What is selective breeding?', 'Humans choosing parents with desired traits to breed.', 12),
  (d_id, 'What is genetic engineering?', 'Transferring genes between organisms using enzymes.', 13),
  (d_id, 'What is a gene?', 'A section of DNA that codes for a protein.', 14),
  (d_id, 'What is an ecosystem?', 'All the organisms and their environment in an area.', 15),
  (d_id, 'What is a habitat?', 'The place where an organism lives.', 16),
  (d_id, 'What is a community?', 'All the populations of different species in a habitat.', 17),
  (d_id, 'What is a producer?', 'A plant making glucose by photosynthesis.', 18),
  (d_id, 'What is a food chain?', 'The feeding relationships transferring energy: producer -> consumer.', 19),
  (d_id, 'How much energy is passed between trophic levels?', 'About 10%.', 20),
  (d_id, 'What is the carbon cycle?', 'Carbon moving between atmosphere, organisms, and Earth (photosynthesis, respiration, combustion, decomposition).', 21),
  (d_id, 'What is the water cycle?', 'Evaporation, condensation, precipitation, transpiration.', 22),
  (d_id, 'What is a predator-prey cycle?', 'Predator and prey populations rise and fall together in a cycle.', 23),
  (d_id, 'How can biodiversity be maintained?', 'Protecting habitats, reducing pollution, conservation programmes.', 24);

  -- GCSE Chemistry - Topic 4-7: Chemical Changes, Energy & Rates (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Chemistry - Topic 4-7: Chemical Changes, Energy & Rates (Y11)', 'SYLLABUS: Acids, electrolysis, energy changes, rates of reaction', 'Chemistry', 11, 25, 27, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is pH 0-6?', 'Acidic.', 0),
  (d_id, 'What is pH 7?', 'Neutral.', 1),
  (d_id, 'What is pH 8-14?', 'Alkaline.', 2),
  (d_id, 'What does an acid produce in water?', 'Hydrogen ions (H+).', 3),
  (d_id, 'What does an alkali produce in water?', 'Hydroxide ions (OH-).', 4),
  (d_id, 'What is the equation for neutralisation?', 'H+ + OH- -> H2O.', 5),
  (d_id, 'What is an indicator?', 'A substance that changes colour with pH (e.g. universal indicator).', 6),
  (d_id, 'What do acids + metals produce?', 'Salt + hydrogen.', 7),
  (d_id, 'What do acids + metal oxides produce?', 'Salt + water.', 8),
  (d_id, 'What do acids + metal carbonates produce?', 'Salt + water + carbon dioxide.', 9),
  (d_id, 'What is the reactivity series?', 'Order of metals by how readily they react: K, Na, Ca, Mg, Al, C, Zn, Fe, Sn, Pb, H, Cu, Ag, Au.', 10),
  (d_id, 'What is electrolysis?', 'Using electricity to decompose a molten or dissolved ionic compound.', 11),
  (d_id, 'What happens at the cathode?', 'Reduction (gain of electrons).', 12),
  (d_id, 'What happens at the anode?', 'Oxidation (loss of electrons).', 13),
  (d_id, 'What is an exothermic reaction?', 'One that transfers energy to the surroundings (temperature rises), e.g. combustion.', 14),
  (d_id, 'What is an endothermic reaction?', 'One that takes in energy (temperature falls), e.g. thermal decomposition.', 15),
  (d_id, 'What is activation energy?', 'The minimum energy needed for a reaction to start.', 16),
  (d_id, 'What is a catalyst?', 'A substance that speeds up a reaction without being used up.', 17),
  (d_id, 'How do catalysts work?', 'They lower activation energy by providing an alternative pathway.', 18),
  (d_id, 'What is the effect of increasing temperature on rate?', 'Particles have more energy, more successful collisions per second.', 19),
  (d_id, 'What is the effect of increasing concentration/pressure?', 'More particles, more frequent collisions.', 20),
  (d_id, 'What is the effect of increasing surface area?', 'More particles exposed, more collisions.', 21),
  (d_id, 'What are the units of rate?', 'Rate = amount of product / time.', 22),
  (d_id, 'What is a reversible reaction?', 'A reaction that can go in both directions (⇌).', 23),
  (d_id, 'What is Le Chatelier''s principle?', 'If a condition changes, equilibrium shifts to oppose the change.', 24);

  -- GCSE Chemistry - Topic 8-10: Organic, Analysis & Resources (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Chemistry - Topic 8-10: Organic, Analysis & Resources (Y11)', 'SYLLABUS: Crude oil, alkanes, alkenes, test tubes chemistry, sustainability', 'Chemistry', 11, 25, 31, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is crude oil?', 'A fossil fuel made of a mixture of hydrocarbons.', 0),
  (d_id, 'What is a hydrocarbon?', 'A compound of only carbon and hydrogen.', 1),
  (d_id, 'What is fractional distillation?', 'Separating crude oil into fractions by boiling point.', 2),
  (d_id, 'Which fraction has the lowest boiling point?', 'Refinery gases (small molecules).', 3),
  (d_id, 'What happens to boiling point as chain length increases?', 'It increases.', 4),
  (d_id, 'What is a homologous series?', 'A family of compounds with the same general formula and similar properties.', 5),
  (d_id, 'What is the general formula of alkanes?', 'CnH2n+2.', 6),
  (d_id, 'What is the general formula of alkenes?', 'CnH2n.', 7),
  (d_id, 'What is the difference between alkanes and alkenes?', 'Alkanes are saturated (single bonds); alkenes are unsaturated (C=C).', 8),
  (d_id, 'What is complete combustion?', 'Burning in plenty of oxygen: hydrocarbon + O2 -> CO2 + H2O.', 9),
  (d_id, 'What is incomplete combustion?', 'Limited oxygen: produces CO (toxic) and soot.', 10),
  (d_id, 'How can alkenes be detected?', 'They decolourise bromine water.', 11),
  (d_id, 'What is cracking?', 'Breaking long-chain hydrocarbons into smaller, more useful ones.', 12),
  (d_id, 'Why is cracking important?', 'Short chains (petrol) are in higher demand and more valuable.', 13),
  (d_id, 'What is a polymer?', 'Long chains made from many monomers.', 14),
  (d_id, 'What is polymerisation?', 'Joining monomers together.', 15),
  (d_id, 'What is addition polymerisation?', 'Alkenes join without losing any atoms.', 16),
  (d_id, 'How do you test for hydrogen?', 'A lighted splint gives a squeaky pop.', 17),
  (d_id, 'How do you test for oxygen?', 'A glowing splint relights.', 18),
  (d_id, 'How do you test for carbon dioxide?', 'Bubbling through limewater turns it cloudy (milky).', 19),
  (d_id, 'How do you test for chlorine?', 'Damp blue litmus paper is bleached white.', 20),
  (d_id, 'What is a finite resource?', 'One that will run out (fossil fuels, metal ores).', 21),
  (d_id, 'How can we reduce the use of resources?', 'Recycling, reuse, reduce, using renewable sources.', 22),
  (d_id, 'What is the Haber process?', 'Making ammonia from nitrogen and hydrogen (N2 + 3H2 ⇌ 2NH3).', 23),
  (d_id, 'What is the equation for making ammonia?', 'N2 + 3H2 ⇌ 2NH3 (iron catalyst, high pressure).', 24);

  -- GCSE Physics - Topic 3: Particle Model & Atomic Structure (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Physics - Topic 3: Particle Model & Atomic Structure (Y11)', 'SYLLABUS: Density, states, specific heat, radioactivity, half-life', 'Physics', 11, 24, 33, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is density?', 'Mass per unit volume (ρ = m/V), units kg/m³.', 0),
  (d_id, 'What is the density of water?', '1000 kg/m³ (1 g/cm³).', 1),
  (d_id, 'Why does ice float?', 'Its density is lower than water''s.', 2),
  (d_id, 'What is the particle model?', 'Matter made of particles; state depends on energy of particles.', 3),
  (d_id, 'What is specific latent heat of fusion?', 'Energy to change 1kg from solid to liquid without temperature change.', 4),
  (d_id, 'What is specific latent heat of vapourisation?', 'Energy to change 1kg from liquid to gas.', 5),
  (d_id, 'What is internal energy?', 'The total kinetic and potential energy of a substance''s particles.', 6),
  (d_id, 'What is pressure in a gas due to?', 'Particles hitting the container walls.', 7),
  (d_id, 'What happens to gas pressure when volume decreases?', 'Pressure increases (more collisions per second).', 8),
  (d_id, 'What is absolute zero?', '-273°C, where particles have minimum energy.', 9),
  (d_id, 'What is the Kelvin scale?', '0 K = -273°C; add 273 to Celsius.', 10),
  (d_id, 'What is the structure of an atom?', 'Nucleus (protons + neutrons) with electrons in shells.', 11),
  (d_id, 'What is an isotope?', 'Atoms of the same element with different numbers of neutrons.', 12),
  (d_id, 'What is alpha radiation?', 'A helium nucleus (2p + 2n), highly ionising, stopped by paper.', 13),
  (d_id, 'What is beta radiation?', 'A fast-moving electron, medium ionising, stopped by a few mm aluminium.', 14),
  (d_id, 'What is gamma radiation?', 'High-energy electromagnetic waves, weakly ionising, stopped by thick lead.', 15),
  (d_id, 'What is alpha particle charge?', '+2.', 16),
  (d_id, 'What is beta particle charge?', '-1.', 17),
  (d_id, 'What is half-life?', 'The time for half the radioactive nuclei to decay.', 18),
  (d_id, 'If half-life is 10 years, how much of 80g remains after 30 years?', '10 g (halves: 80, 40, 20, 10).', 19),
  (d_id, 'What is radioactive contamination?', 'Unwanted radioactive material on objects.', 20),
  (d_id, 'What is irradiation?', 'Exposure to radiation without becoming radioactive.', 21),
  (d_id, 'What is a use of alpha radiation?', 'Smoke detectors.', 22),
  (d_id, 'What is a use of beta/gamma?', 'Medical imaging (tracers) and cancer treatment.', 23);

  -- GCSE Physics - Topic 4: Forces (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Physics - Topic 4: Forces (Y11)', 'SYLLABUS: Newton''s laws, momentum, work, energy, moments', 'Physics', 11, 23, 59, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a scalar quantity?', 'Only magnitude (e.g. speed, mass, energy).', 0),
  (d_id, 'What is a vector quantity?', 'Magnitude and direction (e.g. velocity, force, momentum).', 1),
  (d_id, 'What is the difference between speed and velocity?', 'Velocity has direction; speed does not.', 2),
  (d_id, 'What is Newton''s first law?', 'Objects remain at rest or move uniformly unless acted on by a resultant force.', 3),
  (d_id, 'What is Newton''s second law?', 'Force = mass x acceleration (F = ma).', 4),
  (d_id, 'What is Newton''s third law?', 'Every action has an equal and opposite reaction.', 5),
  (d_id, 'Calculate the force to accelerate 2kg at 3 m/s².', '6 N.', 6),
  (d_id, 'What is weight?', 'Mass x gravitational field strength (W = mg).', 7),
  (d_id, 'What is a resultant force?', 'The single force that replaces all forces acting on an object.', 8),
  (d_id, 'What happens to a falling object''s acceleration as drag increases?', 'It decreases until terminal velocity.', 9),
  (d_id, 'What is terminal velocity?', 'When weight equals drag, so the object falls at constant speed.', 10),
  (d_id, 'What is momentum?', 'mass x velocity (p = mv), units kg m/s.', 11),
  (d_id, 'What is the principle of conservation of momentum?', 'Total momentum before a collision equals total momentum after.', 12),
  (d_id, 'What is work done?', 'Force x distance (W = Fd), units joules.', 13),
  (d_id, 'How much work is done moving 100N over 2m?', '200 J.', 14),
  (d_id, 'What is a moment?', 'Force x perpendicular distance from the pivot (turning effect).', 15),
  (d_id, 'What is the principle of moments?', 'For equilibrium, sum of clockwise moments = sum of anticlockwise moments.', 16),
  (d_id, 'What is a lever?', 'A rigid bar rotating around a pivot to increase a force.', 17),
  (d_id, 'What is pressure?', 'Force / area (p = F/A), units pascals (Pa).', 18),
  (d_id, 'What is a spring''s extension proportional to?', 'The force applied (Hooke''s law, within limit of proportionality).', 19),
  (d_id, 'What is elastic limit?', 'The point beyond which a spring does not return to its original length.', 20),
  (d_id, 'What is the equation for elastic potential energy?', 'EPE = ½ k e² (spring constant x extension²).', 21),
  (d_id, 'What is a vector diagram used for?', 'Adding forces to find the resultant.', 22);

  -- GCSE English Literature - A Christmas Carol (Y11)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE English Literature - A Christmas Carol (Y11)', 'SYLLABUS: Dickens: characters, themes, key quotes, context', 'English', 11, 24, 53, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'Who wrote A Christmas Carol?', 'Charles Dickens (1843).', 0),
  (d_id, 'Who is the protagonist?', 'Ebenezer Scrooge, a miserly old businessman.', 1),
  (d_id, 'How does the novella begin?', '''Marley was dead: to begin with.''', 2),
  (d_id, 'Who is Jacob Marley?', 'Scrooge''s dead business partner, who warns him as a ghost.', 3),
  (d_id, 'What are the three spirits?', 'Ghost of Christmas Past, Present, and Yet to Come.', 4),
  (d_id, 'What does Marley''s ghost carry?', 'Heavy chains of his own greed.', 5),
  (d_id, 'What is the Ghost of Christmas Past?', 'Shows Scrooge his lonely childhood and lost love (Belle).', 6),
  (d_id, 'What does the Ghost of Christmas Present show?', 'The Cratchits, Fezziwig''s party, and the contrast of the poor.', 7),
  (d_id, 'What does the Ghost of Christmas Yet to Come show?', 'Scrooge''s unremembered death and Tiny Tim''s fate.', 8),
  (d_id, 'Who is Tiny Tim?', 'Bob Cratchit''s ill son, who would die without help - ''God bless us, every one!''.', 9),
  (d_id, 'Who is Bob Cratchit?', 'Scrooge''s underpaid clerk.', 10),
  (d_id, 'What is Scrooge''s famous line?', '''Bah, humbug!''.', 11),
  (d_id, 'What does Scrooge call the poor?', '''Are there no prisons? Are there no workhouses?''.', 12),
  (d_id, 'What does ''decrease the surplus population'' refer to?', 'Malthusian views; Scrooge later changes his mind.', 13),
  (d_id, 'What is the main theme?', 'Redemption and the importance of compassion/charity.', 14),
  (d_id, 'What is the moral of the story?', 'It is never too late to change and care for others.', 15),
  (d_id, 'What is a novella?', 'A short novel.', 16),
  (d_id, 'What is the structure of the novella?', 'Five staves (chapters), like a carol''s verses.', 17),
  (d_id, 'What does the weather symbolise?', 'Cold = miserliness; warmth/light = redemption.', 18),
  (d_id, 'How does Dickens show poverty?', 'Ignorance and Want (the two children under the spirit''s robe).', 19),
  (d_id, 'What does the ending suggest?', 'Scrooge''s transformation is genuine and lasting.', 20),
  (d_id, 'What is the significance of the ghosts?', 'To show the past, present, and future consequences of his actions.', 21),
  (d_id, 'Why is the Cratchit family important?', 'To show the human cost of poverty and the value of family love.', 22),
  (d_id, 'What does Dickens criticise?', 'Victorian greed, workhouses, and the Poor Law.', 23);

  -- A-Level Maths - Pure Year 12: Differentiation
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Maths - Pure Year 12: Differentiation', 'SYLLABUS: Gradients, differentiation rules, stationary points, tangents', 'Mathematics', 12, 25, 22, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the gradient of a curve at a point?', 'The rate of change - found by differentiating.', 0),
  (d_id, 'Differentiate x³.', '3x².', 1),
  (d_id, 'Differentiate 5x².', '10x.', 2),
  (d_id, 'Differentiate x⁴ + 3x².', '4x³ + 6x.', 3),
  (d_id, 'Differentiate 7.', '0 (constant).', 4),
  (d_id, 'What is the notation dy/dx?', 'The derivative of y with respect to x.', 5),
  (d_id, 'What does d/dx(1/x) equal?', '-1/x² (rewrite as x⁻¹).', 6),
  (d_id, 'Differentiate √x.', '1/(2√x) (rewrite as x^½).', 7),
  (d_id, 'What is the second derivative?', 'Differentiating twice, written d²y/dx².', 8),
  (d_id, 'What does the second derivative tell you?', 'Concavity; if negative, a max; if positive, a min.', 9),
  (d_id, 'What are stationary points?', 'Points where dy/dx = 0 (max, min, or point of inflection).', 10),
  (d_id, 'How do you find the gradient of y = x² at x = 3?', 'dy/dx = 2x, so 6.', 11),
  (d_id, 'What is the equation of the tangent at a point?', 'y = gradient(x - a) + y-coordinate at x=a.', 12),
  (d_id, 'What is a normal?', 'A line perpendicular to the tangent.', 13),
  (d_id, 'What is the gradient of the normal?', 'The negative reciprocal of the tangent''s gradient.', 14),
  (d_id, 'Find stationary points of y = x² - 4x.', 'Set dy/dx = 0: 2x - 4 = 0, x = 2, y = -4. Minimum.', 15),
  (d_id, 'What is the product rule?', 'If y = uv, dy/dx = u dv/dx + v du/dx.', 16),
  (d_id, 'Differentiate x²sin(x).', 'x²cos(x) + 2x sin(x) (product rule).', 17),
  (d_id, 'What is the quotient rule?', 'If y = u/v, dy/dx = (v du/dx - u dv/dx)/v².', 18),
  (d_id, 'What is the chain rule?', 'dy/dx = dy/du x du/dx.', 19),
  (d_id, 'Differentiate (2x + 1)⁵.', '10(2x + 1)⁴ (chain rule).', 20),
  (d_id, 'Differentiate e^x.', 'e^x.', 21),
  (d_id, 'Differentiate ln(x).', '1/x.', 22),
  (d_id, 'Differentiate sin(x).', 'cos(x).', 23),
  (d_id, 'Differentiate cos(x).', '-sin(x).', 24);

  -- A-Level Maths - Pure Year 12: Integration
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Maths - Pure Year 12: Integration', 'SYLLABUS: Integration rules, definite integrals, areas, substitution', 'Mathematics', 12, 23, 30, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is integration?', 'The reverse of differentiation.', 0),
  (d_id, 'Integrate x².', 'x³/3 + c.', 1),
  (d_id, 'Integrate 2x.', 'x² + c.', 2),
  (d_id, 'What is the rule for integrating xⁿ?', 'x^(n+1)/(n+1) + c (except n = -1).', 3),
  (d_id, 'Integrate 1/x.', 'ln|x| + c.', 4),
  (d_id, 'Integrate e^x.', 'e^x + c.', 5),
  (d_id, 'Integrate cos(x).', 'sin(x) + c.', 6),
  (d_id, 'Integrate sin(x).', '-cos(x) + c.', 7),
  (d_id, 'What is the constant of integration ''c''?', 'A constant because differentiation loses constants.', 8),
  (d_id, 'What is a definite integral?', 'An integral evaluated between limits, giving a number (an area).', 9),
  (d_id, 'What does ∫₀¹ 3x² dx equal?', '[x³]₀¹ = 1.', 10),
  (d_id, 'How do you find the area under a curve?', 'Integrate the function between the limits.', 11),
  (d_id, 'If the area is below the x-axis, the integral is...', 'Negative (take absolute value for area).', 12),
  (d_id, 'What is the area between two curves?', '∫ (top curve - bottom curve) dx.', 13),
  (d_id, 'What is the trapezium rule?', 'An approximate area using trapeziums under the curve.', 14),
  (d_id, 'When is the trapezium rule used?', 'When the integral is too hard to find exactly.', 15),
  (d_id, 'What is integration by substitution?', 'Changing the variable to simplify the integral.', 16),
  (d_id, 'Integrate 2x(x² + 1)³ dx.', 'Let u = x² + 1, du = 2x dx -> u⁴/4 + c = (x²+1)⁴/4 + c.', 17),
  (d_id, 'What is integration by parts?', '∫u dv = uv - ∫v du.', 18),
  (d_id, 'What is the difference between an indefinite and definite integral?', 'Indefinite has +c and no limits; definite has limits and a numeric answer.', 19),
  (d_id, 'What is the area of a region with x from 0 to 2 under y = x?', '2 (½ x base x height = ½ x 2 x 2).', 20),
  (d_id, 'What does ''∫'' represent?', 'The integral sign - sum of infinitely thin strips.', 21),
  (d_id, 'What is the fundamental theorem of calculus?', 'Integration and differentiation are inverse operations.', 22);

  -- A-Level Biology - Biological Molecules (Y12)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Biology - Biological Molecules (Y12)', 'SYLLABUS: Carbohydrates, proteins, lipids, enzymes, ATP', 'Biology', 12, 24, 35, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What are the monomers of carbohydrates?', 'Monosaccharides (glucose, fructose, galactose).', 0),
  (d_id, 'What is a disaccharide?', 'Two monosaccharides joined (e.g. maltose = glucose + glucose).', 1),
  (d_id, 'What is a polysaccharide?', 'Many monosaccharides (e.g. starch, glycogen, cellulose).', 2),
  (d_id, 'What is starch?', 'A storage polysaccharide in plants, made of amylose and amylopectin.', 3),
  (d_id, 'What is glycogen?', 'A highly branched storage polysaccharide in animals.', 4),
  (d_id, 'Why is cellulose strong?', 'Beta-glucose chains linked by hydrogen bonds to form microfibrils.', 5),
  (d_id, 'What is a condensation reaction?', 'Joining monomers, releasing water.', 6),
  (d_id, 'What is a hydrolysis reaction?', 'Breaking polymers, using water.', 7),
  (d_id, 'What are the monomers of proteins?', 'Amino acids.', 8),
  (d_id, 'How many types of amino acids are there?', '20.', 9),
  (d_id, 'What is a peptide bond?', 'The bond between amino acids in a dipeptide/polypeptide.', 10),
  (d_id, 'What are the four levels of protein structure?', 'Primary, secondary (α-helix/β-sheet), tertiary, quaternary.', 11),
  (d_id, 'What is an enzyme?', 'A biological catalyst, usually a protein with a specific active site.', 12),
  (d_id, 'What is the induced fit model?', 'The active site changes shape slightly to fit the substrate.', 13),
  (d_id, 'What is Vmax?', 'The maximum rate of an enzyme reaction.', 14),
  (d_id, 'What is Km?', 'The substrate concentration at half Vmax (lower = higher affinity).', 15),
  (d_id, 'What is a competitive inhibitor?', 'Binds the active site, blocking the substrate.', 16),
  (d_id, 'What is a non-competitive inhibitor?', 'Binds elsewhere, changing the active site shape.', 17),
  (d_id, 'What are the monomers of lipids?', 'Fatty acids and glycerol.', 18),
  (d_id, 'What is a triglyceride?', 'One glycerol + three fatty acids.', 19),
  (d_id, 'What is a phospholipid?', 'Glycerol + two fatty acids + phosphate group (hydrophilic head).', 20),
  (d_id, 'What is ATP?', 'Adenosine triphosphate - the universal energy currency.', 21),
  (d_id, 'What does ATP hydrolysis produce?', 'ADP + Pi + energy (catalysed by ATPase).', 22),
  (d_id, 'What is a reducing sugar test?', 'Benedict''s reagent - turns brick red when heated with sugars.', 23);

  -- A-Level Biology - Cells & Transport (Y12)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Biology - Cells & Transport (Y12)', 'SYLLABUS: Cell structure, organelles, transport across membranes', 'Biology', 12, 24, 32, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the nucleus?', 'Contains chromosomes (DNA), controls the cell.', 0),
  (d_id, 'What is the nucleolus?', 'Makes ribosomes.', 1),
  (d_id, 'What are mitochondria?', 'Sites of aerobic respiration (has cristae and matrix).', 2),
  (d_id, 'What are chloroplasts?', 'Sites of photosynthesis (thylakoids, stroma).', 3),
  (d_id, 'What is the rough ER?', 'Ribosomes on its surface make and transport proteins.', 4),
  (d_id, 'What is the smooth ER?', 'Synthesises and processes lipids.', 5),
  (d_id, 'What is the Golgi apparatus?', 'Processes and packages proteins into vesicles.', 6),
  (d_id, 'What are lysosomes?', 'Contain digestive enzymes to break down waste/pathogens.', 7),
  (d_id, 'What are ribosomes?', 'Make proteins from amino acids (mRNA to protein).', 8),
  (d_id, 'What is the cell wall in plants made of?', 'Cellulose.', 9),
  (d_id, 'What is a prokaryote?', 'A cell without a nucleus (e.g. bacteria).', 10),
  (d_id, 'What is a eukaryote?', 'A cell with a nucleus and membrane-bound organelles.', 11),
  (d_id, 'What extra structures do prokaryotes have?', 'Plasmids, capsules, flagella (no membrane-bound organelles).', 12),
  (d_id, 'What is diffusion?', 'Net movement from high to low concentration (passive).', 13),
  (d_id, 'What affects the rate of diffusion?', 'Concentration gradient, surface area, temperature, membrane thickness.', 14),
  (d_id, 'What is osmosis?', 'Movement of water from high water potential to low across a partially permeable membrane.', 15),
  (d_id, 'What is active transport?', 'Movement against the concentration gradient, using ATP.', 16),
  (d_id, 'What is a co-transporter?', 'A carrier protein moving two molecules together (e.g. glucose and sodium in the gut).', 17),
  (d_id, 'What is endocytosis?', 'Taking large molecules into the cell via vesicles (uses ATP).', 18),
  (d_id, 'What is exocytosis?', 'Releasing large molecules from the cell via vesicles.', 19),
  (d_id, 'What is the cell surface membrane made of?', 'Phospholipid bilayer (fluid mosaic model).', 20),
  (d_id, 'What is a glycoprotein?', 'A carbohydrate-protein complex involved in cell recognition.', 21),
  (d_id, 'What is a tissue?', 'A group of similar cells; an organ is a group of tissues.', 22),
  (d_id, 'What is an organelle?', 'A sub-cellular structure with a specific function.', 23);

  -- A-Level Chemistry - Physical: Moles & Energetics (Y12)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Chemistry - Physical: Moles & Energetics (Y12)', 'SYLLABUS: Amount of substance, mole, enthalpy, calorimetry', 'Chemistry', 12, 24, 27, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a mole?', 'The amount of substance containing 6.02 x 10²³ particles (Avogadro''s constant).', 0),
  (d_id, 'What is Avogadro''s constant?', '6.02 x 10²³ mol⁻¹.', 1),
  (d_id, 'How do you find moles from mass?', 'moles = mass / molar mass (n = m/M).', 2),
  (d_id, 'How many moles in 40g of NaOH (Mr 40)?', '1 mole.', 3),
  (d_id, 'What is molar volume at room temperature and pressure?', '24 dm³ mol⁻¹.', 4),
  (d_id, 'How do you find moles of a gas at RTP?', 'Volume (dm³) / 24.', 5),
  (d_id, 'What is a mole fraction?', 'Moles of a component / total moles (used for partial pressure).', 6),
  (d_id, 'What is the empirical formula?', 'The simplest whole-number ratio of atoms in a compound.', 7),
  (d_id, 'What is the molecular formula?', 'The actual number of atoms (a multiple of empirical).', 8),
  (d_id, 'What is the ideal gas equation?', 'PV = nRT.', 9),
  (d_id, 'What are the units of P, V, R in PV=nRT?', 'P in Pa, V in m³, R = 8.314 J K⁻¹ mol⁻¹, T in K.', 10),
  (d_id, 'What is standard enthalpy change of formation?', 'Enthalpy change when 1 mole of compound forms from its elements under standard conditions.', 11),
  (d_id, 'What is standard enthalpy change of combustion?', 'Enthalpy change when 1 mole of a substance burns completely in oxygen.', 12),
  (d_id, 'What is Hess''s law?', 'The enthalpy change is the same regardless of the route taken.', 13),
  (d_id, 'What is a calorimetry experiment?', 'Measuring temperature change to calculate energy (q = mcΔT).', 14),
  (d_id, 'What is specific heat capacity of water?', '4.18 J g⁻¹ K⁻¹.', 15),
  (d_id, 'Calculate q for 100g water heated by 10K.', 'q = 100 x 4.18 x 10 = 4180 J.', 16),
  (d_id, 'What is an exothermic reaction?', 'One that releases heat (ΔH negative).', 17),
  (d_id, 'What is an endothermic reaction?', 'One that absorbs heat (ΔH positive).', 18),
  (d_id, 'What is bond enthalpy?', 'The energy to break one mole of a bond in gaseous state.', 19),
  (d_id, 'How do you estimate ΔH from bond enthalpies?', 'ΔH = sum of bonds broken - sum of bonds formed.', 20),
  (d_id, 'What is an enthalpy level diagram?', 'A diagram showing energy of reactants vs products.', 21),
  (d_id, 'What is activation energy?', 'The minimum energy for a reaction to occur.', 22),
  (d_id, 'What are standard conditions?', '100 kPa, 298 K, concentrations 1 mol dm⁻³.', 23);

  -- A-Level Physics - Mechanics & Materials (Y12)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Physics - Mechanics & Materials (Y12)', 'SYLLABUS: Kinematics, Newton''s laws, work, energy, materials', 'Physics', 12, 25, 55, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the equation for constant acceleration?', 'v = u + at (SUVAT).', 0),
  (d_id, 'What is the SUVAT equation for displacement?', 's = ut + ½at².', 1),
  (d_id, 'What is the SUVAT equation with no time?', 'v² = u² + 2as.', 2),
  (d_id, 'What is average velocity?', 'displacement / time.', 3),
  (d_id, 'What is the difference between distance and displacement?', 'Displacement is a vector (includes direction).', 4),
  (d_id, 'What is the gradient of a velocity-time graph?', 'Acceleration.', 5),
  (d_id, 'What is the area under a velocity-time graph?', 'Displacement.', 6),
  (d_id, 'What is Newton''s second law?', 'F = ma (resultant force = mass x acceleration).', 7),
  (d_id, 'What is weight?', 'W = mg.', 8),
  (d_id, 'What is momentum?', 'p = mv.', 9),
  (d_id, 'What is the principle of conservation of momentum?', 'Total momentum is conserved in collisions (no external forces).', 10),
  (d_id, 'What is an elastic collision?', 'Kinetic energy is conserved.', 11),
  (d_id, 'What is an inelastic collision?', 'Kinetic energy is lost (e.g. as heat/sound).', 12),
  (d_id, 'What is work done?', 'W = Fd cosθ.', 13),
  (d_id, 'What is the kinetic energy equation?', 'KE = ½mv².', 14),
  (d_id, 'What is gravitational potential energy?', 'GPE = mgh.', 15),
  (d_id, 'What is power?', 'P = work/time = Fv.', 16),
  (d_id, 'What is efficiency?', 'useful output / total input (x 100%).', 17),
  (d_id, 'What is Hooke''s law?', 'Force is proportional to extension (F = kx) within the limit of proportionality.', 18),
  (d_id, 'What is Young''s modulus?', 'stress / strain (measures stiffness).', 19),
  (d_id, 'What is stress?', 'Force / cross-sectional area (Pa).', 20),
  (d_id, 'What is strain?', 'Extension / original length (no units).', 21),
  (d_id, 'What is elastic deformation?', 'The material returns to its original shape when load is removed.', 22),
  (d_id, 'What is plastic deformation?', 'Permanent change - the material does not return to its original shape.', 23),
  (d_id, 'What is tensile strength?', 'The maximum stress a material can withstand before breaking.', 24);

  -- A-Level Psychology - Approaches & Biopsychology (Y12)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Psychology - Approaches & Biopsychology (Y12)', 'SYLLABUS: Approaches in psychology, nervous system, neurons, localisation', 'Psychology', 12, 24, 32, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the behaviourist approach?', 'Learning through classical and operant conditioning (Pavlov, Skinner).', 0),
  (d_id, 'What is classical conditioning?', 'Learning by association (e.g. Pavlov''s dogs - neutral stimulus pairs with unconditioned stimulus).', 1),
  (d_id, 'What is operant conditioning?', 'Learning through consequences - reinforcement and punishment (Skinner).', 2),
  (d_id, 'What is positive reinforcement?', 'Giving a reward to increase a behaviour.', 3),
  (d_id, 'What is the social learning theory?', 'Learning through observation and imitation of role models (Bandura).', 4),
  (d_id, 'What is the cognitive approach?', 'Focuses on internal mental processes (memory, perception, thinking).', 5),
  (d_id, 'What is the biological approach?', 'Explains behaviour through genes, brain structure, and neurochemistry.', 6),
  (d_id, 'What is the psychodynamic approach?', 'Freud: unconscious mind, id/ego/superego, psychosexual stages.', 7),
  (d_id, 'What is the humanistic approach?', 'Focuses on self-actualisation and free will (Maslow, Rogers).', 8),
  (d_id, 'What is the central nervous system?', 'The brain and spinal cord.', 9),
  (d_id, 'What is the peripheral nervous system?', 'Nerves outside the CNS (somatic and autonomic).', 10),
  (d_id, 'What is the somatic nervous system?', 'Controls voluntary movement.', 11),
  (d_id, 'What is the autonomic nervous system?', 'Controls involuntary functions (fight/flight); sympathetic and parasympathetic.', 12),
  (d_id, 'What is the fight or flight response?', 'The sympathetic response to threat: adrenaline, increased heart rate.', 13),
  (d_id, 'What is a neuron?', 'A nerve cell transmitting electrical impulses.', 14),
  (d_id, 'What is a sensory neuron?', 'Carries impulses from receptors to the CNS.', 15),
  (d_id, 'What is a motor neuron?', 'Carries impulses from the CNS to effectors (muscles/glands).', 16),
  (d_id, 'What is a relay neuron?', 'Connects sensory and motor neurons in the CNS.', 17),
  (d_id, 'What is a synapse?', 'The gap between neurons; neurotransmitters cross it.', 18),
  (d_id, 'What is localisation of function?', 'Specific brain areas have specific functions (e.g. Broca''s area = speech).', 19),
  (d_id, 'What is the motor cortex?', 'Controls voluntary movement.', 20),
  (d_id, 'What is the somatosensory cortex?', 'Processes touch, pressure, and temperature.', 21),
  (d_id, 'What is neuroplasticity?', 'The brain''s ability to change and reorganise throughout life.', 22),
  (d_id, 'What is synaptic transmission?', 'Neurotransmitters released into the synapse bind to receptors on the next neuron.', 23);

  -- A-Level Maths - Pure Year 13: Further Calculus
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Maths - Pure Year 13: Further Calculus', 'SYLLABUS: Implicit differentiation, integration by parts, differential equations', 'Mathematics', 13, 24, 57, 1)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is implicit differentiation?', 'Differentiating equations with y as a function of x, using dy/dx.', 0),
  (d_id, 'Differentiate y² implicitly.', '2y dy/dx.', 1),
  (d_id, 'What is integration by parts?', '∫u dv = uv - ∫v du.', 2),
  (d_id, 'Integrate x e^x dx by parts.', 'e^x(x - 1) + c.', 3),
  (d_id, 'What is the parametric equation?', 'x and y defined separately in terms of a parameter (e.g. t).', 4),
  (d_id, 'How do you find dy/dx for parametric equations?', 'dy/dx = (dy/dt)/(dx/dt).', 5),
  (d_id, 'What is a differential equation?', 'An equation involving derivatives, e.g. dy/dx = ky.', 6),
  (d_id, 'Solve dy/dx = 2x (general solution).', 'y = x² + c.', 7),
  (d_id, 'What is a particular solution?', 'A solution found by substituting initial conditions.', 8),
  (d_id, 'Solve dy/dx = ky.', 'y = Ae^(kx).', 9),
  (d_id, 'What is an integrating factor?', 'A function multiplied into a linear differential equation to make it integrable.', 10),
  (d_id, 'What is a separable differential equation?', 'One where dy/dx = f(x)g(y), separated into ∫1/g(y) dy = ∫f(x) dx.', 11),
  (d_id, 'What is the volume of revolution?', 'π∫y² dx (rotating a curve around the x-axis).', 12),
  (d_id, 'What is the arc length formula?', '∫√(1 + (dy/dx)²) dx.', 13),
  (d_id, 'What is the binomial expansion for (1 + x)ⁿ?', '1 + nx + n(n-1)x²/2! + ... for |x|<1.', 14),
  (d_id, 'What is the sum of an arithmetic series?', 'Sn = n/2 (2a + (n-1)d).', 15),
  (d_id, 'What is the sum of a geometric series?', 'Sn = a(1 - rⁿ)/(1 - r); infinite = a/(1 - r) for |r|<1.', 16),
  (d_id, 'What is the modulus function?', '|x| = the positive value of x (e.g. |-3| = 3).', 17),
  (d_id, 'How do you solve |x - 2| = 5?', 'x = 7 or x = -3 (x - 2 = ±5).', 18),
  (d_id, 'What is the compound angle formula for sin(A+B)?', 'sinAcosB + cosAsinB.', 19),
  (d_id, 'What is the compound angle formula for cos(A+B)?', 'cosAcosB - sinAsinB.', 20),
  (d_id, 'What is tan(A+B)?', '(tanA + tanB)/(1 - tanAtanB).', 21),
  (d_id, 'What is the identity sin²θ + cos²θ?', '1.', 22),
  (d_id, 'What is the identity for tan²θ?', 'tan²θ + 1 = sec²θ.', 23);

  -- A-Level Maths - Statistics & Mechanics (Y13)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Maths - Statistics & Mechanics (Y13)', 'SYLLABUS: Probability distributions, hypothesis testing, kinematics, forces', 'Mathematics', 13, 24, 43, 4)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is a random variable?', 'A variable whose value is the outcome of a random experiment.', 0),
  (d_id, 'What is a probability distribution?', 'A list of all outcomes and their probabilities (sum = 1).', 1),
  (d_id, 'What is the binomial distribution?', 'For a fixed number of independent trials with two outcomes (X ~ B(n,p)).', 2),
  (d_id, 'What are the conditions for a binomial distribution?', 'Fixed n, independent trials, constant probability p, two outcomes.', 3),
  (d_id, 'What is the normal distribution?', 'A bell-shaped continuous distribution (X ~ N(μ, σ²)).', 4),
  (d_id, 'What percentage of data lies within 1 standard deviation?', '68%.', 5),
  (d_id, 'What percentage within 2 standard deviations?', '95%.', 6),
  (d_id, 'What percentage within 3 standard deviations?', '99.7%.', 7),
  (d_id, 'What is the standard normal distribution?', 'N(0, 1) - mean 0, standard deviation 1.', 8),
  (d_id, 'What is a hypothesis test?', 'Testing a claim about a population parameter using sample evidence.', 9),
  (d_id, 'What is the null hypothesis (H0)?', 'The assumption to be tested (usually ''no effect'').', 10),
  (d_id, 'What is the alternative hypothesis (H1)?', 'What you believe if H0 is rejected.', 11),
  (d_id, 'What is a significance level?', 'The probability of wrongly rejecting H0 (usually 5% or 1%).', 12),
  (d_id, 'What is a Type I error?', 'Rejecting a true H0 (false positive).', 13),
  (d_id, 'What is a Type II error?', 'Accepting a false H0 (false negative).', 14),
  (d_id, 'What is the p-value?', 'The probability of the result if H0 is true; reject if p < significance level.', 15),
  (d_id, 'What is a critical region?', 'The set of values where H0 is rejected.', 16),
  (d_id, 'What is the mean of a binomial distribution?', 'np.', 17),
  (d_id, 'What is the variance of a binomial distribution?', 'np(1 - p).', 18),
  (d_id, 'What is resultant force?', 'The single force equivalent to all forces acting.', 19),
  (d_id, 'What is the equation for uniform acceleration?', 'v² = u² + 2as.', 20),
  (d_id, 'What is a particle model?', 'An object treated as a point mass (no size/rotation).', 21),
  (d_id, 'What is normal reaction force?', 'The perpendicular force from a surface on an object.', 22),
  (d_id, 'What is friction?', 'A force opposing motion, F = μR (coefficient x normal reaction).', 23);

  -- A-Level Biology - Genetics & Ecosystems (Y13)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Biology - Genetics & Ecosystems (Y13)', 'SYLLABUS: Inheritance, gene expression, ecosystems, energy transfers', 'Biology', 13, 24, 35, 3)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the structure of DNA?', 'A double helix of two polynucleotide strands (base pairs A-T, C-G).', 0),
  (d_id, 'What is a gene?', 'A sequence of DNA coding for a polypeptide.', 1),
  (d_id, 'What is transcription?', 'DNA is copied into mRNA in the nucleus.', 2),
  (d_id, 'What is translation?', 'mRNA is decoded at ribosomes into a polypeptide (tRNA carries amino acids).', 3),
  (d_id, 'What is a codon?', 'Three bases of mRNA coding for one amino acid.', 4),
  (d_id, 'What is a mutation?', 'A change in DNA base sequence.', 5),
  (d_id, 'What is gene mutation?', 'A change in a gene''s base sequence (e.g. substitution, deletion).', 6),
  (d_id, 'What is the Monohybrid ratio?', '3:1 for a cross of two heterozygotes with a dominant trait.', 7),
  (d_id, 'What is the dihybrid ratio?', '9:3:3:1.', 8),
  (d_id, 'What is codominance?', 'Both alleles are expressed in the phenotype (e.g. AB blood group).', 9),
  (d_id, 'What is multiple alleles?', 'More than two alleles for a gene (e.g. ABO blood groups - three alleles).', 10),
  (d_id, 'What is epistasis?', 'One gene masks the expression of another.', 11),
  (d_id, 'What is the chi-squared test?', 'A statistical test comparing observed and expected results.', 12),
  (d_id, 'What is an ecosystem?', 'A community of organisms interacting with their environment.', 13),
  (d_id, 'What is a niche?', 'An organism''s role and its position in the ecosystem.', 14),
  (d_id, 'What is primary productivity?', 'The rate of energy storage by producers (photosynthesis).', 15),
  (d_id, 'How is energy lost between trophic levels?', 'Respiration, excretion, uneaten parts.', 16),
  (d_id, 'What is a biomass pyramid?', 'Shows the mass of organisms at each trophic level.', 17),
  (d_id, 'What is the nitrogen cycle?', 'Nitrogen fixing, nitrification, denitrification, decay.', 18),
  (d_id, 'What does nitrogen-fixing bacteria do?', 'Converts atmospheric nitrogen to ammonia/nitrates (in roots and soil).', 19),
  (d_id, 'What does denitrification do?', 'Converts nitrates back to nitrogen gas (reducing soil fertility).', 20),
  (d_id, 'What is succession?', 'The gradual change of a community over time (to climax community).', 21),
  (d_id, 'What is a pioneer species?', 'The first species to colonise bare land.', 22),
  (d_id, 'How can sustainable ecosystems be managed?', 'Balancing conservation and resource use (e.g. fishing quotas, replanting).', 23);

  -- A-Level Chemistry - Organic & Analysis (Y13)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Chemistry - Organic & Analysis (Y13)', 'SYLLABUS: Organic synthesis, mechanisms, NMR, mass spec', 'Chemistry', 13, 24, 30, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is an alkane?', 'A saturated hydrocarbon with only single C-C bonds (CnH2n+2).', 0),
  (d_id, 'What is an alkene?', 'An unsaturated hydrocarbon with a C=C bond (CnH2n).', 1),
  (d_id, 'What is an alcohol?', 'A compound with an -OH group (e.g. ethanol).', 2),
  (d_id, 'What is a carboxylic acid?', 'A compound with a -COOH group (ethanoic acid).', 3),
  (d_id, 'What is an ester?', 'Formed from alcohol + carboxylic acid, with a -COO- group.', 4),
  (d_id, 'What is an aldehyde?', 'A carbonyl at the end of a chain (-CHO).', 5),
  (d_id, 'What is a ketone?', 'A carbonyl within the chain (R-CO-R).', 6),
  (d_id, 'What is an amine?', 'A compound with an -NH2 group (base).', 7),
  (d_id, 'What is an amide?', 'A carboxylic acid derivative with -CONH2.', 8),
  (d_id, 'What is the functional group of a halogenoalkane?', 'A halogen (F, Cl, Br, I) replacing a hydrogen.', 9),
  (d_id, 'What is nucleophilic substitution?', 'A nucleophile (e.g. OH-) replaces a halogen in a halogenoalkane.', 10),
  (d_id, 'What is elimination in organic chemistry?', 'Removing a small molecule (e.g. H2O) to form a double bond.', 11),
  (d_id, 'What is electrophilic addition?', 'An electrophile adds across a C=C double bond.', 12),
  (d_id, 'What is a free radical?', 'A species with an unpaired electron (highly reactive).', 13),
  (d_id, 'What is the mechanism for halogenation of alkanes?', 'Free radical substitution (needs UV light).', 14),
  (d_id, 'What is oxidation of an alcohol?', 'Primary -> aldehyde -> carboxylic acid; secondary -> ketone.', 15),
  (d_id, 'What oxidising agent is used for alcohols?', 'Acidified potassium dichromate (orange -> green).', 16),
  (d_id, 'What is dehydration of ethanol?', 'Ethene + water (with concentrated H2SO4).', 17),
  (d_id, 'What is polymerisation?', 'Joining monomers into polymers (addition or condensation).', 18),
  (d_id, 'What is a condensation polymer?', 'Monomers join losing a small molecule (e.g. polyester).', 19),
  (d_id, 'What is NMR spectroscopy?', 'Nuclear Magnetic Resonance - detects hydrogen/carbon environments.', 20),
  (d_id, 'What does mass spectrometry measure?', 'The mass-to-charge ratio of ions to find Mr and fragments.', 21),
  (d_id, 'What is infrared spectroscopy used for?', 'Identifying functional groups by their absorption peaks.', 22),
  (d_id, 'How many signals in the ¹H NMR of ethanol?', '3 (CH3, CH2, OH).', 23);

  -- A-Level Physics - Fields & Nuclear (Y13)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Physics - Fields & Nuclear (Y13)', 'SYLLABUS: Circular motion, gravitation, electric fields, nuclear physics', 'Physics', 13, 26, 25, 0)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is angular velocity?', 'ω = θ/t, measured in rad s⁻¹.', 0),
  (d_id, 'What is the equation for centripetal force?', 'F = mv²/r = mω²r.', 1),
  (d_id, 'What is centripetal acceleration?', 'a = v²/r = ω²r (towards the centre).', 2),
  (d_id, 'What provides the centripetal force for a satellite?', 'Gravity.', 3),
  (d_id, 'What is Newton''s law of gravitation?', 'F = Gm1m2/r².', 4),
  (d_id, 'What is the gravitational field strength?', 'g = GM/r².', 5),
  (d_id, 'What is gravitational potential energy?', 'E = -GMm/r (negative; zero at infinity).', 6),
  (d_id, 'What is escape velocity?', 'The speed needed to escape a gravitational field without further thrust.', 7),
  (d_id, 'What is Kepler''s third law?', 'T² ∝ r³ (orbital period squared proportional to radius cubed).', 8),
  (d_id, 'What is an electric field?', 'A region where a charge experiences a force.', 9),
  (d_id, 'What is Coulomb''s law?', 'F = kQ1Q2/r².', 10),
  (d_id, 'What is electric field strength?', 'E = F/q = V/d (for a uniform field).', 11),
  (d_id, 'What is capacitance?', 'C = Q/V, measured in farads (F).', 12),
  (d_id, 'What is the energy stored in a capacitor?', 'E = ½CV² = ½QV.', 13),
  (d_id, 'What is the time constant of a capacitor?', 'RC - time to discharge to 37%.', 14),
  (d_id, 'What is magnetic flux?', 'Φ = BA (field strength x area).', 15),
  (d_id, 'What is electromagnetic induction?', 'A changing flux through a coil induces an emf (Faraday''s law).', 16),
  (d_id, 'What is Faraday''s law?', 'Induced emf = rate of change of magnetic flux.', 17),
  (d_id, 'What is Lenz''s law?', 'Induced current opposes the change causing it (conservation of energy).', 18),
  (d_id, 'What is the strong nuclear force?', 'The force holding nucleons together in the nucleus.', 19),
  (d_id, 'What is radioactive decay?', 'The spontaneous random breakdown of unstable nuclei.', 20),
  (d_id, 'What is alpha decay?', 'Emits a helium nucleus (2p, 2n); mass number -4, atomic number -2.', 21),
  (d_id, 'What is beta decay?', 'A neutron -> proton + electron + antineutrino; atomic number +1.', 22),
  (d_id, 'What is half-life?', 'The time for half the nuclei to decay.', 23),
  (d_id, 'What is nuclear fission?', 'Splitting a large nucleus (e.g. uranium) to release energy.', 24),
  (d_id, 'What is nuclear fusion?', 'Joining small nuclei (e.g. hydrogen) to form helium, releasing energy.', 25);

  -- A-Level Psychology - Issues, Debates & Schizophrenia (Y13)
  INSERT INTO decks (id, user_id, title, description, subject, year_group, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'A-Level Psychology - Issues, Debates & Schizophrenia (Y13)', 'SYLLABUS: Debates, schizophrenia, research methods, statistics', 'Psychology', 13, 25, 42, 2)
  RETURNING id INTO d_id;
  INSERT INTO cards (deck_id, front, back, position) VALUES
  (d_id, 'What is the nature vs nurture debate?', 'Whether behaviour is due to genes (nature) or environment (nurture).', 0),
  (d_id, 'What is free will vs determinism?', 'Whether behaviour is freely chosen or caused by prior factors.', 1),
  (d_id, 'What is holism vs reductionism?', 'Whether to study whole systems or break behaviour into parts.', 2),
  (d_id, 'What is idiographic vs nomothetic?', 'Idiographic = individual case studies; nomothetic = general laws.', 3),
  (d_id, 'What is the nature of schizophrenia?', 'A severe mental disorder with positive and negative symptoms.', 4),
  (d_id, 'What are positive symptoms of schizophrenia?', 'Hallucinations and delusions.', 5),
  (d_id, 'What are negative symptoms of schizophrenia?', 'Avolition (lack of motivation) and speech poverty.', 6),
  (d_id, 'What is the dopamine hypothesis?', 'Schizophrenia is linked to excess dopamine activity.', 7),
  (d_id, 'What is a hallucination?', 'A sensory experience without an external stimulus (e.g. hearing voices).', 8),
  (d_id, 'What is a delusion?', 'A firmly held false belief (e.g. paranoia).', 9),
  (d_id, 'What is the genetic explanation of schizophrenia?', 'It runs in families; polygenic and influenced by the environment.', 10),
  (d_id, 'What is concordance rate?', 'The probability that both twins have the disorder if one does.', 11),
  (d_id, 'What is the cognitive explanation of schizophrenia?', 'Dysfunctional thought processes (e.g. impaired attention, source monitoring).', 12),
  (d_id, 'What is a typical antipsychotic?', 'Dopamine antagonists reducing positive symptoms.', 13),
  (d_id, 'What is an atypical antipsychotic?', 'Targets dopamine and serotonin with fewer side effects.', 14),
  (d_id, 'What is CBT for schizophrenia?', 'Challenging delusions and reducing distress.', 15),
  (d_id, 'What is family therapy?', 'Reducing expressed emotion (criticism/hostility) in families.', 16),
  (d_id, 'What is an independent variable?', 'What the researcher manipulates.', 17),
  (d_id, 'What is a dependent variable?', 'What the researcher measures.', 18),
  (d_id, 'What is an extraneous variable?', 'A variable that could affect results if not controlled.', 19),
  (d_id, 'What is a confounding variable?', 'A variable that changes with the IV, affecting results.', 20),
  (d_id, 'What is the significance level used in psychology?', 'p < 0.05.', 21),
  (d_id, 'What is a Type I error?', 'Rejecting the null hypothesis when it is true (false positive).', 22),
  (d_id, 'What is a Type II error?', 'Accepting the null hypothesis when it is false (false negative).', 23),
  (d_id, 'What is the sign test used for?', 'Nominal data in a repeated measures design.', 24);

  -- Guide: GCSE Maths Full Syllabus Guide
  INSERT INTO study_guides (id, user_id, title, subject, year_group, content, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Maths Full Syllabus Guide', 'Mathematics', 11, E'# GCSE Maths Full Syllabus Revision Guide

## 1. Number
- Standard form, surds, indices, and bounds
- Fractions, decimals, percentages, ratio, and proportion
- Compound interest: A = P(1 + r/n)^(nt)
- Reverse percentages and percentage change

## 2. Algebra
- Expanding and factorising quadratics
- Solving quadratic equations (factorising, formula, completing the square)
- Simultaneous equations (linear and quadratic)
- Inequalities and number lines
- nth term, quadratic sequences, and geometric sequences
- Graphs: linear, quadratic, cubic, reciprocal, exponential

## 3. Ratio, Proportion & Rates of Change
- Direct and inverse proportion
- Speed, density, pressure (compound measures)
- Gradient of curves and rates of change

## 4. Geometry & Measures
- Circle theorems (angle at centre, semicircle, alternate segment)
- Pythagoras and trigonometry (SOH CAH TOA, sine/cosine rules)
- Bearings and loci
- Volume and surface area of 3D shapes
- Vectors

## 5. Probability & Statistics
- Probability trees and Venn diagrams
- Cumulative frequency and box plots
- Histograms and frequency polygons
- Averages and measures of spread

> Tip: Practise past papers. Focus on your weakest area each week.', 46, 3)
;

  -- Guide: GCSE Biology Full Syllabus Guide
  INSERT INTO study_guides (id, user_id, title, subject, year_group, content, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Biology Full Syllabus Guide', 'Biology', 11, E'# GCSE Biology Full Syllabus Revision Guide

## Topic 1: Cell Biology
- Cell structure (plant, animal, bacterial)
- Diffusion, osmosis, active transport
- Cell division: mitosis and meiosis
- Stem cells

## Topic 2: Organisation
- Enzymes and digestion
- The heart, blood, and lungs
- Plant transport: xylem, phloem, transpiration

## Topic 3: Infection & Response
- Pathogens, diseases, and defences
- Vaccination, antibiotics, and painkillers
- Monoclonal antibodies and drug development

## Topic 4: Bioenergetics
- Photosynthesis and limiting factors
- Aerobic and anaerobic respiration
- Response to exercise

## Topic 5: Homeostasis
- The nervous system and reflexes
- Hormones (insulin, glucagon, ADH, menstrual cycle)
- The brain, eye, and kidneys

## Topic 6: Inheritance, Variation & Evolution
- DNA, genes, chromosomes, alleles
- Punnett squares, sex determination, genetic disorders
- Evolution, natural selection, and speciation
- Selective breeding, genetic engineering, cloning

## Topic 7: Ecology
- Ecosystems, food chains, and energy transfer
- The carbon and water cycles
- Biodiversity, pollution, and sustainability

> Tip: Draw and label diagrams - they earn marks and aid memory.', 30, 3)
;

  -- Guide: GCSE Chemistry Full Syllabus Guide
  INSERT INTO study_guides (id, user_id, title, subject, year_group, content, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Chemistry Full Syllabus Guide', 'Chemistry', 11, E'# GCSE Chemistry Full Syllabus Revision Guide

## Topic 1: Atomic Structure
- Subatomic particles, isotopes, and electron configuration
- The periodic table and its history (Mendeleev)

## Topic 2: Bonding
- Ionic, covalent, and metallic bonding
- Giant structures (diamond, graphite, graphene) and properties
- Nanoparticles

## Topic 3: Quantitative Chemistry
- Relative formula mass and the mole
- Balancing equations and reacting masses
- Concentration and titrations

## Topic 4: Chemical Changes
- Reactivity series and displacement
- Acids, alkalis, and salts
- Electrolysis

## Topic 5: Energy Changes
- Exothermic and endothermic reactions
- Bond energies

## Topic 6: Rate & Extent of Chemical Change
- Factors affecting rate (temperature, concentration, surface area, catalysts)
- Reversible reactions and equilibrium

## Topic 7: Organic Chemistry
- Crude oil, alkanes, alkenes
- Cracking and polymers

## Topic 8: Chemical Analysis
- Tests for gases, ions, and pure substances

## Topic 9: Chemistry of the Atmosphere
- Gases, climate change, and pollutants

## Topic 10: Using Resources
- Sustainable development, recycling, and the Haber process

> Tip: Practise balancing equations and titration calculations until automatic.', 45, 3)
;

  -- Guide: GCSE Physics Full Syllabus Guide
  INSERT INTO study_guides (id, user_id, title, subject, year_group, content, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'GCSE Physics Full Syllabus Guide', 'Physics', 11, E'# GCSE Physics Full Syllabus Revision Guide

## Topic 1: Energy
- Energy stores and transfers
- Kinetic and gravitational potential energy equations
- Efficiency and power
- Renewable and non-renewable resources

## Topic 2: Electricity
- Circuit rules (series and parallel)
- Ohm''s law, resistance, power, and energy
- Mains electricity, fuses, and the national grid
- Static electricity

## Topic 3: Particle Model
- Density and states of matter
- Internal energy, specific heat, and latent heat
- Gas pressure

## Topic 4: Atomic Structure
- The atom, isotopes, and ions
- Alpha, beta, gamma radiation
- Half-life and uses of radiation

## Topic 5: Forces
- Newton''s laws, momentum, and terminal velocity
- Work, energy, and moments
- Pressure in fluids
- Forces and elasticity

## Topic 6: Waves
- Transverse and longitudinal waves
- The electromagnetic spectrum
- Reflection, refraction, and sound
- Lenses and light

## Topic 7: Magnetism & Electromagnetism
- Permanent and induced magnets
- Electromagnets, motors, and generators
- The motor effect and transformers

## Topic 8: Space (Physics only)
- The solar system, gravity, and orbits
- Life cycle of stars and red-shift

> Tip: Learn every equation and its units - the data sheet helps, but units earn marks.', 44, 0)
;

  RAISE NOTICE 'Full syllabus seed complete: 61 decks and 4 guides added.';
END;
$$;

SELECT seed_full_syllabus();
DROP FUNCTION seed_full_syllabus();