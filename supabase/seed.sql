-- Run this ENTIRE script in your Supabase SQL Editor (SQL Editor tab in dashboard)
-- It creates a temporary user and seeds all study materials

-- First, create a service function to insert seed data
CREATE OR REPLACE FUNCTION seed_study_data()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  seed_user_id uuid;
  deck_id_1 uuid;
  deck_id_2 uuid;
  deck_id_3 uuid;
  deck_id_4 uuid;
  deck_id_5 uuid;
  deck_id_6 uuid;
  deck_id_7 uuid;
  deck_id_8 uuid;
  deck_id_9 uuid;
  deck_id_10 uuid;
  deck_id_11 uuid;
  deck_id_12 uuid;
  deck_id_13 uuid;
BEGIN
  -- Check if data already exists
  IF EXISTS (SELECT 1 FROM decks LIMIT 1) THEN
    RAISE NOTICE 'Data already exists, skipping seed.';
    RETURN;
  END IF;

  -- Create a seed user in auth (or use existing)
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, created_at, updated_at, confirmation_token, recovery_token, email_change_token_new, email_change)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated', 'seed@studyswap.app', crypt('seedpassword123', gen_salt('bf')), now(), now(), now(), '', '', '', '')
  ON CONFLICT DO NOTHING
  RETURNING id INTO seed_user_id;

  -- If user already existed, just grab any user
  IF seed_user_id IS NULL THEN
    SELECT id INTO seed_user_id FROM auth.users LIMIT 1;
  END IF;

  -- Create profile
  INSERT INTO profiles (id, username) VALUES (seed_user_id, 'StudySwap Seed')
  ON CONFLICT (id) DO NOTHING;

  -- ===== DECK 1: Biology - Cell Structure =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Biology 101 - Cell Structure', 'Essential terms for understanding cell biology', 'Biology', 20, 47, 3)
  RETURNING id INTO deck_id_1;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_1, 'What is the nucleus?', 'The membrane-bound organelle that contains the cell DNA and controls gene expression', 0),
  (deck_id_1, 'What is a mitochondria?', 'The powerhouse of the cell; organelle responsible for cellular respiration and ATP production', 1),
  (deck_id_1, 'What is the function of ribosomes?', 'Protein synthesis - they translate mRNA into polypeptide chains', 2),
  (deck_id_1, 'What is the endoplasmic reticulum (ER)?', 'A network of membranes involved in protein (rough ER) and lipid (smooth ER) synthesis', 3),
  (deck_id_1, 'What is the Golgi apparatus?', 'Modifies, sorts, and packages proteins and lipids for secretion or delivery to other organelles', 4),
  (deck_id_1, 'What is the cell membrane?', 'A phospholipid bilayer that regulates what enters and exits the cell (selectively permeable)', 5),
  (deck_id_1, 'What is the cytoskeleton?', 'A network of protein filaments that gives the cell shape and structure', 6),
  (deck_id_1, 'What is a lysosome?', 'A membrane-bound organelle containing digestive enzymes for breaking down waste', 7),
  (deck_id_1, 'Prokaryotic vs Eukaryotic cells?', 'Prokaryotes lack a nucleus and membrane-bound organelles; eukaryotes have both', 8),
  (deck_id_1, 'What is a vacuole?', 'A membrane-bound sac used for storage of water, nutrients, or waste products', 9),
  (deck_id_1, 'What is the cell wall?', 'A rigid outer layer found in plants (cellulose) and fungi (chitin) that provides structural support', 10),
  (deck_id_1, 'What is the rough ER?', 'Endoplasmic reticulum studded with ribosomes; involved in protein synthesis', 11),
  (deck_id_1, 'What is the smooth ER?', 'Endoplasmic reticulum without ribosomes; involved in lipid synthesis and detoxification', 12),
  (deck_id_1, 'What is ATP?', 'Adenosine triphosphate - the primary energy currency of the cell', 13),
  (deck_id_1, 'What is osmosis?', 'The movement of water molecules across a semipermeable membrane from low to high solute concentration', 14),
  (deck_id_1, 'What is active transport?', 'Movement of molecules against the concentration gradient, requiring energy (ATP)', 15),
  (deck_id_1, 'What is diffusion?', 'The movement of particles from an area of high concentration to low concentration', 16),
  (deck_id_1, 'What is endocytosis?', 'The process by which cells take in materials by engulfing them in a vesicle', 17),
  (deck_id_1, 'What is exocytosis?', 'The process by which cells release materials by fusing vesicles with the cell membrane', 18),
  (deck_id_1, 'Mitochondria double membrane?', 'The outer membrane is permeable; the inner membrane is folded into cristae for the electron transport chain', 19);

  -- ===== DECK 2: Biology - Genetics =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Biology 101 - Genetics', 'Key genetics concepts and terminology', 'Biology', 20, 38, 5)
  RETURNING id INTO deck_id_2;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_2, 'What is DNA?', 'Deoxyribonucleic acid - a double-helix molecule that carries genetic instructions', 0),
  (deck_id_2, 'What is a gene?', 'A segment of DNA that codes for a specific protein or RNA molecule', 1),
  (deck_id_2, 'What is an allele?', 'Alternative forms of a gene found at the same locus on a chromosome', 2),
  (deck_id_2, 'Genotype vs phenotype?', 'Genotype is the genetic makeup; phenotype is the observable physical traits', 3),
  (deck_id_2, 'What is a dominant allele?', 'An allele that expresses its phenotype even when only one copy is present', 4),
  (deck_id_2, 'What is a recessive allele?', 'An allele that only expresses when two copies are present', 5),
  (deck_id_2, 'Law of Segregation?', 'Each individual has two alleles for each gene, and these alleles separate during gamete formation', 6),
  (deck_id_2, 'What is a Punnett square?', 'A diagram used to predict the genotypic and phenotypic outcomes of a genetic cross', 7),
  (deck_id_2, 'Incomplete dominance?', 'Heterozygous phenotype is a blend of both alleles (e.g., pink flowers from red and white)', 8),
  (deck_id_2, 'What is codominance?', 'Both alleles are fully expressed in the heterozygote (e.g., AB blood type)', 9),
  (deck_id_2, 'What is a carrier?', 'An individual heterozygous for a recessive trait who can pass it on', 10),
  (deck_id_2, 'What is a pedigree?', 'A diagram showing the inheritance of a trait through generations of a family', 11),
  (deck_id_2, 'What is genetic drift?', 'Random changes in allele frequencies in a population over time', 12),
  (deck_id_2, 'What is natural selection?', 'Organisms with favorable traits are more likely to survive and reproduce', 13),
  (deck_id_2, 'What is a mutation?', 'A permanent change in the DNA sequence that can affect gene function', 14),
  (deck_id_2, 'What is mRNA?', 'Messenger RNA - carries genetic code from DNA to ribosomes for protein synthesis', 15),
  (deck_id_2, 'What is transcription?', 'The process of copying a segment of DNA into mRNA', 16),
  (deck_id_2, 'What is translation?', 'The process of synthesizing a protein from the mRNA template at the ribosome', 17),
  (deck_id_2, 'What is the Central Dogma?', 'DNA -> RNA -> Protein: genetic information flows from DNA to RNA to protein', 18),
  (deck_id_2, 'What is a karyotype?', 'An individual collection of chromosomes showing their number, size, and shape', 19);

  -- ===== DECK 3: Chemistry - Periodic Table =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Chemistry 101 - Periodic Table', 'Essential elements and periodic trends', 'Chemistry', 20, 52, 2)
  RETURNING id INTO deck_id_3;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_3, 'What is an element?', 'A pure substance consisting of only one type of atom, defined by its atomic number', 0),
  (deck_id_3, 'What is atomic number?', 'The number of protons in the nucleus; defines the element', 1),
  (deck_id_3, 'What is atomic mass?', 'The weighted average mass of an atom isotopes, measured in amu', 2),
  (deck_id_3, 'What is a group on the periodic table?', 'A vertical column; elements have similar chemical properties', 3),
  (deck_id_3, 'What is a period on the periodic table?', 'A horizontal row; elements have the same number of electron shells', 4),
  (deck_id_3, 'What are alkali metals?', 'Group 1 elements - highly reactive metals with one valence electron', 5),
  (deck_id_3, 'What are halogens?', 'Group 17 elements - highly reactive nonmetals with seven valence electrons', 6),
  (deck_id_3, 'What are noble gases?', 'Group 18 elements - inert gases with full valence electron shells', 7),
  (deck_id_3, 'What is electronegativity?', 'The tendency of an atom to attract electrons in a chemical bond (highest: fluorine)', 8),
  (deck_id_3, 'What is ionization energy?', 'The energy required to remove an electron from a gaseous atom', 9),
  (deck_id_3, 'Atomic radius trend?', 'Increases down a group (more shells) and decreases across a period', 10),
  (deck_id_3, 'What is a metalloid?', 'Elements with properties between metals and nonmetals (e.g., Si, Ge, As)', 11),
  (deck_id_3, 'What is an isotope?', 'Atoms of the same element with different numbers of neutrons', 12),
  (deck_id_3, 'What is an ion?', 'An atom that has gained or lost electrons, giving it a charge', 13),
  (deck_id_3, 'What is oxidation?', 'Loss of electrons (OIL RIG: Oxidation Is Loss, Reduction Is Gain)', 14),
  (deck_id_3, 'What is reduction?', 'Gain of electrons by an atom', 15),
  (deck_id_3, 'What is the octet rule?', 'Atoms tend to achieve 8 electrons in their outer shell', 16),
  (deck_id_3, 'What is a covalent bond?', 'A bond formed by sharing electrons between nonmetal atoms', 17),
  (deck_id_3, 'What is an ionic bond?', 'A bond formed by the transfer of electrons from a metal to a nonmetal', 18),
  (deck_id_3, 'Metallic character trend?', 'Decreases across a period (left to right) and increases down a group', 19);

  -- ===== DECK 4: Physics - Mechanics =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Physics 101 - Mechanics', 'Fundamental mechanics concepts and formulas', 'Physics', 20, 41, 4)
  RETURNING id INTO deck_id_4;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_4, 'Newton First Law?', 'An object at rest stays at rest, and in motion stays in motion, unless acted upon by an external force', 0),
  (deck_id_4, 'Newton Second Law?', 'F = ma: Net force equals mass times acceleration', 1),
  (deck_id_4, 'Newton Third Law?', 'For every action, there is an equal and opposite reaction', 2),
  (deck_id_4, 'What is velocity?', 'The rate of change of displacement; speed with direction (v = d/t)', 3),
  (deck_id_4, 'What is acceleration?', 'The rate of change of velocity (a = dv/dt). Units: m/s2', 4),
  (deck_id_4, 'Kinetic energy formula?', 'KE = 1/2 mv^2 (mass times velocity squared, divided by two)', 5),
  (deck_id_4, 'Gravitational potential energy?', 'GPE = mgh (mass x gravity x height)', 6),
  (deck_id_4, 'What is momentum?', 'p = mv: The product of mass and velocity. A vector quantity.', 7),
  (deck_id_4, 'Conservation of Momentum?', 'In a closed system, total momentum before collision equals total momentum after', 8),
  (deck_id_4, 'Mass vs weight?', 'Mass is amount of matter (kg); weight is force of gravity (W = mg, in Newtons)', 9),
  (deck_id_4, 'What is friction?', 'A force that opposes motion between two surfaces in contact', 10),
  (deck_id_4, 'What is normal force?', 'The perpendicular contact force exerted by a surface on an object resting on it', 11),
  (deck_id_4, 'What is projectile motion?', 'Motion of an object launched into the air, subject only to gravity (parabolic path)', 12),
  (deck_id_4, 'What is centripetal force?', 'Net force directed toward the center of a circular path', 13),
  (deck_id_4, 'What is work in physics?', 'W = Fd cos(theta): Force times displacement times cosine of angle. Units: Joules', 14),
  (deck_id_4, 'What is power?', 'P = W/t: Rate of doing work. Units: Watts', 15),
  (deck_id_4, 'What is elastic collision?', 'A collision where both momentum and kinetic energy are conserved', 16),
  (deck_id_4, 'What is inelastic collision?', 'Momentum is conserved but kinetic energy is not', 17),
  (deck_id_4, 'What is perfectly inelastic?', 'Two objects stick together after collision (maximum KE loss)', 18),
  (deck_id_4, 'What is free fall?', 'Motion under gravity alone (a = g = 9.8 m/s2, downward)', 19);

  -- ===== DECK 5: US History =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'US History - Colonial America', 'Key events and figures from colonial America', 'History', 20, 33, 2)
  RETURNING id INTO deck_id_5;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_5, 'When was Jamestown founded?', '1607 - the first permanent English settlement in North America', 0),
  (deck_id_5, 'What was the Mayflower Compact?', 'A 1620 agreement by Pilgrims to create a self-governing body; early democracy', 1),
  (deck_id_5, 'Who were the Puritans?', 'English Protestants who settled Massachusetts Bay Colony in 1630', 2),
  (deck_id_5, 'What was the Salem Witch Trials?', '1692 series of witchcraft hearings in Salem, MA (20 executed)', 3),
  (deck_id_5, 'What was the Great Awakening?', 'Series of Christian revivals in the 1730s-1740s emphasizing personal religious experience', 4),
  (deck_id_5, 'What were the Navigation Acts?', 'Laws restricting colonial trade to benefit Britain (1651-1765)', 5),
  (deck_id_5, 'French and Indian War?', '1754-1763 conflict between Britain and France for control of North America', 6),
  (deck_id_5, 'Proclamation of 1763?', 'British decree forbidding settlement west of the Appalachian Mountains', 7),
  (deck_id_5, 'What was the Stamp Act?', '1765 tax on printed materials; sparked No taxation without representation', 8),
  (deck_id_5, 'What was the Boston Massacre?', '1770 confrontation where British soldiers killed five colonists', 9),
  (deck_id_5, 'What was the Boston Tea Party?', '1773 protest dumping 342 chests of tea into Boston Harbor', 10),
  (deck_id_5, 'What were the Intolerable Acts?', '1774 British laws punishing Massachusetts; closed Boston Harbor', 11),
  (deck_id_5, 'First Continental Congress?', '1772 meeting of delegates from 12 colonies to coordinate resistance', 12),
  (deck_id_5, 'When was the Declaration of Independence signed?', 'July 4, 1776', 13),
  (deck_id_5, 'Who wrote the Declaration of Independence?', 'Thomas Jefferson, with help from Franklin, Adams, and others', 14),
  (deck_id_5, 'Purpose of colonial education?', 'To train clergy and civic leaders; Harvard (1636) was the first colonial college', 15),
  (deck_id_5, 'What was indentured servitude?', 'Working for 4-7 years in exchange for passage to America', 16),
  (deck_id_5, 'What was the triangular trade?', 'Trade route between Europe, Africa, and the Americas', 17),
  (deck_id_5, 'What was the Quebec Act?', '1774 act extending Quebec boundaries; angered American colonists', 18),
  (deck_id_5, 'Committees of Correspondence?', 'Communication networks to coordinate resistance against British policies', 19);

  -- ===== DECK 6: Spanish Basics =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Spanish Basics - Common Phrases', 'Essential Spanish phrases for beginners', 'Languages', 20, 55, 1)
  RETURNING id INTO deck_id_6;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_6, 'Hello / Hi', 'Hola', 0),
  (deck_id_6, 'Good morning', 'Buenos dias', 1),
  (deck_id_6, 'Good afternoon', 'Buenas tardes', 2),
  (deck_id_6, 'Good night', 'Buenas noches', 3),
  (deck_id_6, 'How are you?', 'Como estas?', 4),
  (deck_id_6, 'I am fine, thank you', 'Estoy bien, gracias', 5),
  (deck_id_6, 'What is your name?', 'Como te llamas?', 6),
  (deck_id_6, 'My name is...', 'Me llamo...', 7),
  (deck_id_6, 'Nice to meet you', 'Mucho gusto', 8),
  (deck_id_6, 'Please', 'Por favor', 9),
  (deck_id_6, 'Thank you', 'Gracias', 10),
  (deck_id_6, 'You are welcome', 'De nada', 11),
  (deck_id_6, 'I am sorry', 'Lo siento', 12),
  (deck_id_6, 'Excuse me', 'Disculpe', 13),
  (deck_id_6, 'Yes / No', 'Si / No', 14),
  (deck_id_6, 'I do not understand', 'No entiendo', 15),
  (deck_id_6, 'Do you speak English?', 'Hablas ingles?', 16),
  (deck_id_6, 'How much does it cost?', 'Cuanto cuesta?', 17),
  (deck_id_6, 'Where is the bathroom?', 'Donde esta el bano?', 18),
  (deck_id_6, 'I would like...', 'Me gustaria...', 19);

  -- ===== DECK 7: Computer Science - Data Structures =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Computer Science - Data Structures', 'Fundamental data structures and their properties', 'Computer Science', 20, 61, 3)
  RETURNING id INTO deck_id_7;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_7, 'What is an array?', 'A collection of elements at contiguous memory locations, accessed by index. O(1) access.', 0),
  (deck_id_7, 'What is a linked list?', 'Linear data structure where nodes are non-contiguous, each pointing to the next. O(n) access.', 1),
  (deck_id_7, 'What is a stack?', 'LIFO data structure. Push adds to top, pop removes from top. O(1) operations.', 2),
  (deck_id_7, 'What is a queue?', 'FIFO data structure. Enqueue adds to back, dequeue removes from front. O(1) operations.', 3),
  (deck_id_7, 'What is a hash table?', 'Key-value store using a hash function. Average O(1) lookup.', 4),
  (deck_id_7, 'What is a binary tree?', 'A tree where each node has at most two children (left and right).', 5),
  (deck_id_7, 'What is a BST?', 'Binary Search Tree: left child < parent < right child. O(log n) search, insert, delete.', 6),
  (deck_id_7, 'What is a heap?', 'Complete binary tree where parent >= (max-heap) or <= (min-heap) children.', 7),
  (deck_id_7, 'What is a graph?', 'Collection of vertices connected by edges. Directed or undirected, weighted or unweighted.', 8),
  (deck_id_7, 'What is Big-O notation?', 'Describes upper bound of time/space complexity (e.g., O(n), O(log n), O(n^2))', 9),
  (deck_id_7, 'What is BFS?', 'Breadth-First Search: explores all neighbors at present depth before moving deeper. Uses a queue.', 10),
  (deck_id_7, 'What is DFS?', 'Depth-First Search: explores as far as possible along each branch before backtracking.', 11),
  (deck_id_7, 'What is a hash collision?', 'Two different keys produce the same hash index. Resolved by chaining or open addressing.', 12),
  (deck_id_7, 'Common sorting complexities?', 'Bubble sort O(n^2), merge sort O(n log n), quicksort O(n log n) average.', 13),
  (deck_id_7, 'What is recursion?', 'A function that calls itself with a smaller input until reaching a base case.', 14),
  (deck_id_7, 'Queue used for in BFS?', 'Tracks order of nodes to visit, ensuring level-by-level traversal.', 15),
  (deck_id_7, 'Stack used for in DFS?', 'Tracks path of visited nodes, enabling backtracking at dead ends.', 16),
  (deck_id_7, 'What is dynamic programming?', 'Solves complex problems by breaking into overlapping subproblems and storing results.', 17),
  (deck_id_7, 'What is memoization?', 'Storing results of expensive function calls and returning cached result for same inputs.', 18),
  (deck_id_7, 'What is a trie?', 'Tree-like data structure for efficient string retrieval, commonly used for autocomplete.', 19);

  -- ===== DECK 8: Math - Calculus =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Mathematics - Calculus Basics', 'Fundamental calculus concepts and derivatives', 'Mathematics', 20, 44, 6)
  RETURNING id INTO deck_id_8;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_8, 'What is a limit?', 'The value a function approaches as the input approaches some value. lim(x->a) f(x) = L', 0),
  (deck_id_8, 'What is a derivative?', 'The rate of change of a function. f(x) = lim(h->0) [f(x+h) - f(x)] / h', 1),
  (deck_id_8, 'Power Rule?', 'd/dx [x^n] = nx^(n-1)', 2),
  (deck_id_8, 'Chain Rule?', 'd/dx [f(g(x))] = f(g(x)) * g(x). Differentiate outer, multiply by derivative of inner.', 3),
  (deck_id_8, 'Product Rule?', 'd/dx [f*g] = f*g + fg. Derivative of a product of two functions.', 4),
  (deck_id_8, 'Quotient Rule?', 'd/dx [f/g] = (f*g - fg) / g^2', 5),
  (deck_id_8, 'What is an integral?', 'Reverse of differentiation; represents area under a curve. f(x)dx = F(x) + C', 6),
  (deck_id_8, 'Fundamental Theorem of Calculus?', 'Links differentiation and integration: integral[a,b] f(x)dx = F(b) - F(a)', 7),
  (deck_id_8, 'What is continuity?', 'f(a) exists, lim(x->a) f(x) exists, and lim(x->a) f(x) = f(a)', 8),
  (deck_id_8, 'Derivative of sin(x)?', 'cos(x)', 9),
  (deck_id_8, 'Derivative of cos(x)?', '-sin(x)', 10),
  (deck_id_8, 'Derivative of e^x?', 'e^x (its own derivative)', 11),
  (deck_id_8, 'Derivative of ln(x)?', '1/x', 12),
  (deck_id_8, 'What is a critical point?', 'Where f(x) = 0 or f(x) is undefined. Candidates for local maxima or minima.', 13),
  (deck_id_8, 'Mean Value Theorem?', 'There exists c in (a,b) where f(c) = [f(b)-f(a)]/(b-a)', 14),
  (deck_id_8, 'What is an antiderivative?', 'A function F(x) such that F(x) = f(x). Also called indefinite integral.', 15),
  (deck_id_8, 'Integration by substitution?', 'Reverse of chain rule. Let u = g(x), then du = g(x)dx.', 16),
  (deck_id_8, 'Derivative of tan(x)?', 'sec^2(x)', 17),
  (deck_id_8, 'Left vs right-hand limit?', 'Left: x approaches from less than. Right: x approaches from greater than.', 18),
  (deck_id_8, 'L Hopital Rule?', 'If limit produces 0/0 or inf/inf, then lim f(x)/g(x) = lim f(x)/g(x)', 19);

  -- ===== DECK 9: Psychology =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Psychology 101 - Foundations', 'Introduction to psychology key concepts', 'Psychology', 20, 36, 4)
  RETURNING id INTO deck_id_9;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_9, 'What is psychology?', 'The scientific study of behavior and mental processes', 0),
  (deck_id_9, 'Father of psychoanalysis?', 'Sigmund Freud - developed psychoanalytic theory emphasizing the unconscious mind', 1),
  (deck_id_9, 'What is classical conditioning?', 'Learning through association (Pavlov dogs: neutral stimulus paired with unconditioned stimulus)', 2),
  (deck_id_9, 'What is operant conditioning?', 'Learning through consequences - shaped by reinforcement or punishment (Skinner)', 3),
  (deck_id_9, 'Id, ego, superego?', 'Freud model: Id (primal desires), Ego (reality), Superego (morality)', 4),
  (deck_id_9, 'Cognitive dissonance?', 'Mental discomfort from contradictory beliefs, leading to attitude change', 5),
  (deck_id_9, 'Maslow hierarchy of needs?', 'physiological -> safety -> love/belonging -> esteem -> self-actualization', 6),
  (deck_id_9, 'Stanford Prison Experiment?', '1971 Zimbardo study: guards became authoritarian; stopped after 6 days', 7),
  (deck_id_9, 'Milgram experiment?', '1963: 65% of participants obeyed orders to administer lethal electric shocks', 8),
  (deck_id_9, 'What is the placebo effect?', 'Beneficial effect from a placebo that cannot be attributed to the treatment itself', 9),
  (deck_id_9, 'What is neuroplasticity?', 'The brain ability to reorganize itself by forming new neural connections', 10),
  (deck_id_9, 'Fight-or-flight response?', 'Acute stress response triggered by adrenaline and cortisol, preparing for danger', 11),
  (deck_id_9, 'What is confirmation bias?', 'Tendency to search for and favor information confirming pre-existing beliefs', 12),
  (deck_id_9, 'What is a phobia?', 'Intense irrational fear leading to avoidance behavior', 13),
  (deck_id_9, 'Self-fulfilling prophecy?', 'A prediction that causes itself to become true due to confirming behavior', 14),
  (deck_id_9, 'Positive reinforcement?', 'Adding pleasant stimulus after behavior to increase its recurrence', 15),
  (deck_id_9, 'Negative reinforcement?', 'Removing unpleasant stimulus after behavior to increase its recurrence', 16),
  (deck_id_9, 'Bandura Social Learning Theory?', 'People learn through observation, imitation, and modeling (Bobo doll)', 17),
  (deck_id_9, 'What is the bystander effect?', 'Individuals less likely to help when other people are present', 18),
  (deck_id_9, 'Working memory capacity?', 'Temporarily holding info: ~7 items, ~20 seconds duration', 19);

  -- ===== DECK 10: Economics =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Economics 101 - Microeconomics', 'Core microeconomics principles', 'Economics', 20, 29, 3)
  RETURNING id INTO deck_id_10;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_10, 'What is supply and demand?', 'Supply: quantity offered at prices. Demand: quantity wanted at prices. Equilibrium where they meet.', 0),
  (deck_id_10, 'What is opportunity cost?', 'The value of the next best alternative given up when making a choice', 1),
  (deck_id_10, 'What is elasticity?', 'Measure of how much quantity demanded/supplied changes with price', 2),
  (deck_id_10, 'Perfectly competitive market?', 'Many buyers/sellers, identical products, no barriers, perfect information', 3),
  (deck_id_10, 'What is a monopoly?', 'Single seller with no close substitutes and high barriers to entry', 4),
  (deck_id_10, 'What is marginal utility?', 'Additional satisfaction from consuming one more unit of a good', 5),
  (deck_id_10, 'Law of diminishing returns?', 'Adding more of one input while holding others constant eventually decreases marginal output', 6),
  (deck_id_10, 'What is GDP?', 'Gross Domestic Product - total market value of all final goods/services produced', 7),
  (deck_id_10, 'What is inflation?', 'General increase in prices over time, reducing purchasing power', 8),
  (deck_id_10, 'What is a tariff?', 'Tax on imported goods to protect domestic industries', 9),
  (deck_id_10, 'What is a subsidy?', 'Government payment to producers to encourage production', 10),
  (deck_id_10, 'Fixed vs variable costs?', 'Fixed: dont change with output (rent). Variable: change with output (materials).', 11),
  (deck_id_10, 'What is deadweight loss?', 'Loss of economic efficiency when equilibrium is not achieved', 12),
  (deck_id_10, 'Comparative advantage?', 'Ability to produce a good at lower opportunity cost than another producer', 13),
  (deck_id_10, 'What is a normal good?', 'Demand increases as consumer income increases', 14),
  (deck_id_10, 'What is an inferior good?', 'Demand decreases as consumer income increases (e.g., instant noodles)', 15),
  (deck_id_10, 'What is economies of scale?', 'Cost advantages from increased production (average cost per unit decreases)', 16),
  (deck_id_10, 'What is a price ceiling?', 'Gov maximum price below equilibrium (e.g., rent control). Can cause shortages.', 17),
  (deck_id_10, 'What is a price floor?', 'Gov minimum price above equilibrium (e.g., minimum wage). Can cause surpluses.', 18),
  (deck_id_10, 'Cobb-Douglas production function?', 'Y = A*L^a*K^b: models output from labor (L) and capital (K)', 19);

  -- ===== DECK 11: English - Shakespeare =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'English Literature - Shakespeare', 'Key Shakespeare works, characters, and terms', 'English', 20, 31, 2)
  RETURNING id INTO deck_id_11;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_11, 'Who wrote Romeo and Juliet?', 'William Shakespeare, around 1594-1596', 0),
  (deck_id_11, 'What is a soliloquy?', 'A speech by a character alone on stage, revealing inner thoughts', 1),
  (deck_id_11, 'What is iambic pentameter?', '10 syllables per line with alternating unstressed/stressed (da-DUM x5)', 2),
  (deck_id_11, 'Who is the protagonist of Hamlet?', 'Prince Hamlet, who seeks to avenge his father murder', 3),
  (deck_id_11, 'Tragedy in Macbeth?', 'Unchecked ambition and murder of Duncan lead to downfall and death', 4),
  (deck_id_11, 'All the world is a stage?', 'From As You Like It - comparing life to a play with different roles at different ages', 5),
  (deck_id_11, 'Who is the villain in Othello?', 'Iago, who manipulates Othello into believing Desdemona is unfaithful', 6),
  (deck_id_11, 'What is a sonnet?', '14-line poem with ABAB CDCD EFEF GG rhyme scheme', 7),
  (deck_id_11, 'What is dramatic irony?', 'Audience knows something characters dont (e.g., Romeo thinks Juliet is dead)', 8),
  (deck_id_11, 'A Midsummer Night Dream?', 'Comedy where fairies interfere with Athenian lovers in an enchanted forest', 9),
  (deck_id_11, 'What is the Globe Theatre?', 'Shakespeare open-air theatre in London, built 1599', 10),
  (deck_id_11, 'What is a foil character?', 'Character who contrasts another to highlight qualities (Laertes vs Hamlet)', 11),
  (deck_id_11, 'Power theme in Macbeth?', 'Power corrupts; lust for power leads to moral decay, madness, destruction', 12),
  (deck_id_11, 'What is blank verse?', 'Unrhymed iambic pentameter - most common Shakespeare dialogue form', 13),
  (deck_id_11, 'Who is Puck?', 'Mischievous fairy who creates chaos with a love potion in Midsummer Night Dream', 14),
  (deck_id_11, 'Et tu, Brute?', 'Caesars last words in Julius Caesar, expressing shock at Brutus betrayal', 15),
  (deck_id_11, 'Comedy in Shakespeares terms?', 'Play ending happily with marriages/reconciliation (Twelfth Night, Much Ado)', 16),
  (deck_id_11, 'What is The Tempest?', 'Prospero uses magic on an island to restore his position and reconcile with enemies', 17),
  (deck_id_11, 'Most performed Shakespeare play?', 'Hamlet', 18),
  (deck_id_11, 'Shakespearean tragedy?', 'Serious play with unhappy ending, noble protagonist downfall (Hamlet, Macbeth, Lear, Othello)', 19);

  -- ===== DECK 12: Geography =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Geography - World Capitals', 'Essential world capitals and countries', 'Geography', 20, 48, 0)
  RETURNING id INTO deck_id_12;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_12, 'Capital of Japan?', 'Tokyo', 0),
  (deck_id_12, 'Capital of Australia?', 'Canberra (not Sydney!)', 1),
  (deck_id_12, 'Capital of Brazil?', 'Brasilia (not Rio de Janeiro!)', 2),
  (deck_id_12, 'Capital of Canada?', 'Ottawa (not Toronto!)', 3),
  (deck_id_12, 'Capital of India?', 'New Delhi', 4),
  (deck_id_12, 'Capital of Egypt?', 'Cairo', 5),
  (deck_id_12, 'Capital of South Korea?', 'Seoul', 6),
  (deck_id_12, 'Capital of Turkey?', 'Ankara (not Istanbul!)', 7),
  (deck_id_12, 'Capital of South Africa?', 'Pretoria (admin), Cape Town (legislative), Bloemfontein (judicial)', 8),
  (deck_id_12, 'Capital of China?', 'Beijing', 9),
  (deck_id_12, 'Capital of Russia?', 'Moscow', 10),
  (deck_id_12, 'Capital of Germany?', 'Berlin', 11),
  (deck_id_12, 'Capital of France?', 'Paris', 12),
  (deck_id_12, 'Capital of the United Kingdom?', 'London', 13),
  (deck_id_12, 'Capital of Mexico?', 'Mexico City', 14),
  (deck_id_12, 'Capital of Argentina?', 'Buenos Aires', 15),
  (deck_id_12, 'Capital of Thailand?', 'Bangkok', 16),
  (deck_id_12, 'Capital of Kenya?', 'Nairobi', 17),
  (deck_id_12, 'Capital of Saudi Arabia?', 'Riyadh', 18),
  (deck_id_12, 'Capital of New Zealand?', 'Wellington (not Auckland!)', 19);

  -- ===== DECK 13: Philosophy =====
  INSERT INTO decks (id, user_id, title, description, subject, card_count, upvotes, downvotes)
  VALUES (gen_random_uuid(), seed_user_id, 'Philosophy 101 - Key Thinkers', 'Major philosophers and their ideas', 'Philosophy', 20, 27, 1)
  RETURNING id INTO deck_id_13;

  INSERT INTO cards (deck_id, front, back, position) VALUES
  (deck_id_13, 'I think therefore I am?', 'Rene Descartes - foundational statement of existence as a thinking being (Cogito ergo sum)', 0),
  (deck_id_13, 'Plato Allegory of the Cave?', 'Prisoners see only shadows; represents journey from ignorance to enlightenment', 1),
  (deck_id_13, 'Aristotle Ethics about?', 'Virtue ethics - pursuit of eudaimonia through virtues (the golden mean)', 2),
  (deck_id_13, 'Kant Categorical Imperative?', 'Act only according to universalizable rules; treat people as ends, never merely as means', 3),
  (deck_id_13, 'What is utilitarianism?', 'Greatest good for greatest number (Bentham, Mill)', 4),
  (deck_id_13, 'Nietzsche Will to Power?', 'Fundamental drive of all things to assert and enhance strength and creativity', 5),
  (deck_id_13, 'Who wrote The Republic?', 'Plato - dialogue about justice, the ideal state, and the philosopher-king', 6),
  (deck_id_13, 'What is existentialism?', 'Individual freedom, responsibility, search for meaning (Sartre, Camus, Kierkegaard)', 7),
  (deck_id_13, 'Veil of Ignorance?', 'John Rawls thought experiment: design a just society without knowing your position', 8),
  (deck_id_13, 'Descartes Method of Doubt?', 'Systematically doubting everything to find what is certainly true', 9),
  (deck_id_13, 'State of nature?', 'Hypothetical condition before government (Hobbes: war; Locke: rights; Rousseau: noble savage)', 10),
  (deck_id_13, 'What is the Socratic method?', 'Questioning to expose contradictions and arrive at deeper understanding', 11),
  (deck_id_13, 'What is Stoicism?', 'Virtue and rationality, accepting what you cannot control (Epictetus, Marcus Aurelius)', 12),
  (deck_id_13, 'What is Epicureanism?', 'Pursuit of pleasure through simple living, friendship, absence of fear', 13),
  (deck_id_13, 'What is the trolley problem?', 'Ethical dilemma: redirect trolley to kill 1 instead of 5? Tests utilitarian vs deontological ethics', 14),
  (deck_id_13, 'Who wrote The Social Contract?', 'Jean-Jacques Rousseau - legitimate government based on consent of the governed', 15),
  (deck_id_13, 'Camus Myth of Sisyphus?', 'Embrace the absurd; imagine Sisyphus happy despite his task', 16),
  (deck_id_13, 'Hegel dialectic?', 'Thesis -> Antithesis -> Synthesis: progress through resolving contradictions', 17),
  (deck_id_13, 'What is Occam Razor?', 'Simplest explanation accounting for all facts is preferred', 18),
  (deck_id_13, 'Ship of Theseus paradox?', 'If you replace every plank, is it the same ship? Questions identity and persistence.', 19);

  -- ===== STUDY GUIDES =====
  INSERT INTO study_guides (user_id, title, subject, content, upvotes, downvotes) VALUES
  (seed_user_id, 'Biology 101 - Complete Study Guide', 'Biology',
   E'# Biology 101 - Complete Study Guide\n\n## Chapter 1: Cell Biology\nCells are the basic unit of life.\n\n### Prokaryotic vs Eukaryotic Cells\n- **Prokaryotes**: No nucleus, no membrane-bound organelles\n- **Eukaryotes**: Have a nucleus and membrane-bound organelles\n\n### Key Organelles\n- Nucleus: Contains DNA, controls cell activities\n- Mitochondria: Cellular respiration, ATP production\n- Ribosomes: Protein synthesis\n- ER (Rough): Protein modification\n- ER (Smooth): Lipid synthesis\n- Golgi Apparatus: Package and ship proteins\n- Lysosomes: Digest cellular waste\n- Cell Membrane: Phospholipid bilayer\n\n## Chapter 2: Genetics\n### DNA Structure\n- Double helix, nucleotides (A, T, G, C)\n- Base pairing: A-T, G-C\n\n### Protein Synthesis\n1. Transcription: DNA -> mRNA\n2. Translation: mRNA -> Protein\n\n### Mendelian Genetics\n- Dominant (A) masks recessive (a)\n- Punnett squares predict offspring ratios', 34, 2),

  (seed_user_id, 'Physics Formula Sheet', 'Physics',
   E'# Physics Formula Sheet - Mechanics\n\n## Kinematics\n- v = v0 + at\n- x = x0 + v0t + 1/2at^2\n- v^2 = v0^2 + 2a(x - x0)\n\n## Newton Laws\n1. Inertia (objects resist changes in motion)\n2. F = ma\n3. F_AB = -F_BA\n\n## Energy\n- KE = 1/2 mv^2\n- PE = mgh\n- Work = Fd cos(theta)\n- Power = W/t\n\n## Momentum\n- p = mv\n- Impulse = F*t = delta(p)\n- Conservation: m1v1 + m2v2 = m1v1 + m2v2\n\n## Constants\n- g = 9.8 m/s2\n- c = 3 x 10^8 m/s', 28, 1),

  (seed_user_id, 'Spanish Verb Conjugation Guide', 'Languages',
   E'# Spanish Verb Conjugation Guide\n\n## Regular -AR (Hablar)\nYo hablo, Tu hablas, El habla\nNosotros hablamos, Vosotros hablais, Ellos hablan\n\n## Regular -ER (Comer)\nYo como, Tu comes, El come\nNosotros comemos, Vosotros comes, Ellos comen\n\n## Regular -IR (Vivir)\nYo vivo, Tu vives, El vive\nNosotros vivimos, Vosotros vivis, Ellos viven\n\n## Common Irregular Verbs\n- Ser (identity): soy, eres, es, somos, sois, son\n- Estar (location): estoy, estas, esta, estamos, estais, estan\n- Tener (have): tengo, tienes, tiene, tenemos, teneis, tienen\n- Ir (go): voy, vas, va, vamos, vais, van\n\n## Ser vs Estar\n- Ser: Identity, characteristics, time, origin\n- Estar: Location, emotions, conditions, progressive', 22, 0);

  RAISE NOTICE 'Seed complete! 13 decks with 260 cards and 3 study guides inserted.';
END;
$$;

-- Run the seed function
SELECT seed_study_data();

-- Clean up the function
DROP FUNCTION seed_study_data();
