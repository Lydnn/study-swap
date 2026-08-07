"use client";

import { useState } from "react";
import { createClient } from "@/lib/supabase/client";
import { useAuth } from "@/lib/auth-context";
import { Subject } from "@/types";
import { Database, CheckCircle, AlertCircle, Lock } from "lucide-react";
import Link from "next/link";

const DECKS: {
  title: string;
  subject: Subject;
  description: string;
  cards: { front: string; back: string }[];
}[] = [
  {
    title: "Biology 101 - Cell Structure",
    subject: "Biology",
    description: "Essential terms for understanding cell biology",
    cards: [
      { front: "What is the nucleus?", back: "The membrane-bound organelle that contains the cell's DNA and controls gene expression" },
      { front: "What is a mitochondria?", back: "The powerhouse of the cell; organelle responsible for cellular respiration and ATP production" },
      { front: "What is the function of ribosomes?", back: "Protein synthesis - they translate mRNA into polypeptide chains" },
      { front: "What is the endoplasmic reticulum (ER)?", back: "A network of membranes involved in protein (rough ER) and lipid (smooth ER) synthesis" },
      { front: "What is the Golgi apparatus?", back: "Modifies, sorts, and packages proteins and lipids for secretion or delivery to other organelles" },
      { front: "What is the cell membrane?", back: "A phospholipid bilayer that regulates what enters and exits the cell (selectively permeable)" },
      { front: "What is the cytoskeleton?", back: "A network of protein filaments (microfilaments, intermediate filaments, microtubules) that gives the cell shape and structure" },
      { front: "What is a lysosome?", back: "A membrane-bound organelle containing digestive enzymes for breaking down waste and cellular debris" },
      { front: "What is the difference between prokaryotic and eukaryotic cells?", back: "Prokaryotes lack a nucleus and membrane-bound organelles; eukaryotes have both" },
      { front: "What is a vacuole?", back: "A membrane-bound sac used for storage of water, nutrients, or waste products" },
      { front: "What is the cell wall?", back: "A rigid outer layer found in plants (cellulose) and fungi (chitin) that provides structural support" },
      { front: "What is the rough ER?", back: "Endoplasmic reticulum studded with ribosomes; involved in protein synthesis and modification" },
      { front: "What is the smooth ER?", back: "Endoplasmic reticulum without ribosomes; involved in lipid synthesis and detoxification" },
      { front: "What is ATP?", back: "Adenosine triphosphate - the primary energy currency of the cell" },
      { front: "What is osmosis?", back: "The movement of water molecules across a semipermeable membrane from low to high solute concentration" },
      { front: "What is active transport?", back: "Movement of molecules across a cell membrane against the concentration gradient, requiring energy (ATP)" },
      { front: "What is diffusion?", back: "The movement of particles from an area of high concentration to an area of low concentration" },
      { front: "What is endocytosis?", back: "The process by which cells take in materials by engulfing them in a vesicle formed from the cell membrane" },
      { front: "What is exocytosis?", back: "The process by which cells release materials by fusing vesicles with the cell membrane" },
      { front: "What is the mitochondria's double membrane?", back: "The outer membrane is permeable; the inner membrane is folded into cristae and is the site of the electron transport chain" },
    ],
  },
  {
    title: "Biology 101 - Genetics",
    subject: "Biology",
    description: "Key genetics concepts and terminology",
    cards: [
      { front: "What is DNA?", back: "Deoxyribonucleic acid - a double-helix molecule that carries genetic instructions" },
      { front: "What is a gene?", back: "A segment of DNA that codes for a specific protein or RNA molecule" },
      { front: "What is an allele?", back: "Alternative forms of a gene that arise by mutation and are found at the same locus on a chromosome" },
      { front: "What is genotype vs phenotype?", back: "Genotype is the genetic makeup; phenotype is the observable physical traits" },
      { front: "What is a dominant allele?", back: "An allele that expresses its phenotype even when only one copy is present (capital letter, e.g., A)" },
      { front: "What is a recessive allele?", back: "An allele that only expresses its phenotype when two copies are present (lowercase letter, e.g., a)" },
      { front: "What is Mendel's Law of Segregation?", back: "Each individual has two alleles for each gene, and these alleles separate during gamete formation" },
      { front: "What is a Punnett square?", back: "A diagram used to predict the genotypic and phenotypic outcomes of a genetic cross" },
      { front: "What is incomplete dominance?", back: "A form of intermediate inheritance where the heterozygous phenotype is a blend of both alleles (e.g., pink flowers from red and white)" },
      { front: "What is codominance?", back: "Both alleles are fully expressed in the heterozygote (e.g., AB blood type)" },
      { front: "What is a carrier?", back: "An individual who is heterozygous for a recessive trait and does not express it but can pass it on" },
      { front: "What is a pedigree?", back: "A diagram that shows the inheritance of a trait through generations of a family" },
      { front: "What is genetic drift?", back: "Random changes in allele frequencies in a population over time, especially in small populations" },
      { front: "What is natural selection?", back: "The process where organisms with favorable traits are more likely to survive and reproduce" },
      { front: "What is a mutation?", back: "A permanent change in the DNA sequence that can affect gene function" },
      { front: "What is mRNA?", back: "Messenger RNA - carries the genetic code from DNA in the nucleus to ribosomes for protein synthesis" },
      { front: "What is transcription?", back: "The process of copying a segment of DNA into mRNA" },
      { front: "What is translation?", back: "The process of synthesizing a protein from the mRNA template at the ribosome" },
      { front: "What is the Central Dogma?", back: "DNA → RNA → Protein: genetic information flows from DNA to RNA to protein" },
      { front: "What is a karyotype?", back: "An individual's collection of chromosomes, showing their number, size, and shape" },
    ],
  },
  {
    title: "Chemistry 101 - Periodic Table",
    subject: "Chemistry",
    description: "Essential elements and periodic trends",
    cards: [
      { front: "What is an element?", back: "A pure substance consisting of only one type of atom, defined by its atomic number" },
      { front: "What is atomic number?", back: "The number of protons in the nucleus of an atom; defines the element" },
      { front: "What is atomic mass?", back: "The weighted average mass of an atom's isotopes, measured in atomic mass units (amu)" },
      { front: "What is a group on the periodic table?", back: "A vertical column; elements in the same group have similar chemical properties" },
      { front: "What is a period on the periodic table?", back: "A horizontal row; elements in the same period have the same number of electron shells" },
      { front: "What are alkali metals?", back: "Group 1 elements (Li, Na, K, etc.) - highly reactive metals with one valence electron" },
      { front: "What are halogens?", back: "Group 17 elements (F, Cl, Br, etc.) - highly reactive nonmetals with seven valence electrons" },
      { front: "What are noble gases?", back: "Group 18 elements (He, Ne, Ar, etc.) - inert gases with full valence electron shells" },
      { front: "What is electronegativity?", back: "The tendency of an atom to attract electrons in a chemical bond (highest: fluorine)" },
      { front: "What is ionization energy?", back: "The energy required to remove an electron from a gaseous atom" },
      { front: "What is atomic radius trend?", back: "Atomic radius increases down a group (more shells) and decreases across a period (more protons pull electrons closer)" },
      { front: "What is a metalloid?", back: "Elements with properties between metals and nonmetals (e.g., Si, Ge, As)" },
      { front: "What is an isotope?", back: "Atoms of the same element with different numbers of neutrons (same atomic number, different mass number)" },
      { front: "What is an ion?", back: "An atom that has gained or lost electrons, giving it a positive (cation) or negative (anion) charge" },
      { front: "What is oxidation?", back: "Loss of electrons by an atom (OIL RIG: Oxidation Is Loss, Reduction Is Gain)" },
      { front: "What is reduction?", back: "Gain of electrons by an atom" },
      { front: "What is the octet rule?", back: "Atoms tend to gain, lose, or share electrons to achieve 8 electrons in their outer shell" },
      { front: "What is a covalent bond?", back: "A bond formed by sharing electrons between nonmetal atoms" },
      { front: "What is an ionic bond?", back: "A bond formed by the transfer of electrons from a metal to a nonmetal" },
      { front: "What is a period trend for metallic character?", back: "Metallic character decreases across a period (left to right) and increases down a group" },
    ],
  },
  {
    title: "Physics 101 - Mechanics",
    subject: "Physics",
    description: "Fundamental mechanics concepts and formulas",
    cards: [
      { front: "What is Newton's First Law?", back: "An object at rest stays at rest, and an object in motion stays in motion with the same speed and direction, unless acted upon by an external force (Law of Inertia)" },
      { front: "What is Newton's Second Law?", back: "F = ma: The net force on an object equals its mass times its acceleration" },
      { front: "What is Newton's Third Law?", back: "For every action, there is an equal and opposite reaction" },
      { front: "What is velocity?", back: "The rate of change of displacement; speed with direction (v = Δx/Δt)" },
      { front: "What is acceleration?", back: "The rate of change of velocity (a = Δv/Δt). Units: m/s²" },
      { front: "What is the formula for kinetic energy?", back: "KE = ½mv² (where m = mass, v = velocity)" },
      { front: "What is the formula for gravitational potential energy?", back: "GPE = mgh (where m = mass, g = 9.8 m/s², h = height)" },
      { front: "What is momentum?", back: "p = mv: The product of mass and velocity. A vector quantity." },
      { front: "What is the Law of Conservation of Momentum?", back: "In a closed system, the total momentum before a collision equals the total momentum after" },
      { front: "What is the difference between mass and weight?", back: "Mass is the amount of matter (kg); weight is the force of gravity on that mass (W = mg, in Newtons)" },
      { front: "What is friction?", back: "A force that opposes motion between two surfaces in contact" },
      { front: "What is the normal force?", back: "The perpendicular contact force exerted by a surface on an object resting on it" },
      { front: "What is projectile motion?", back: "The motion of an object launched into the air, subject only to gravity (parabolic path)" },
      { front: "What is centripetal force?", back: "The net force directed toward the center of a circular path, keeping an object in circular motion" },
      { front: "What is work in physics?", back: "W = Fd cos(θ): Force times displacement times the cosine of the angle between them. Units: Joules" },
      { front: "What is power?", back: "P = W/t: The rate at which work is done or energy is transferred. Units: Watts" },
      { front: "What is an elastic collision?", back: "A collision where both momentum and kinetic energy are conserved" },
      { front: "What is an inelastic collision?", back: "A collision where momentum is conserved but kinetic energy is not (some is converted to heat/sound)" },
      { front: "What is a perfectly inelastic collision?", back: "Two objects stick together after collision (maximum kinetic energy loss while conserving momentum)" },
      { front: "What is free fall?", back: "Motion under the influence of gravity alone (a = g = 9.8 m/s², downward)" },
    ],
  },
  {
    title: "US History - Colonial America",
    subject: "History",
    description: "Key events and figures from colonial America",
    cards: [
      { front: "When was Jamestown founded?", back: "1607 - the first permanent English settlement in North America, located in Virginia" },
      { front: "What was the Mayflower Compact?", back: "A 1620 agreement by Pilgrims on the Mayflower to create a self-governing body; an early form of democracy" },
      { front: "Who were the Puritans?", back: "English Protestants who sought to purify the Church of England; settled Massachusetts Bay Colony in 1630" },
      { front: "What was the Salem Witch Trials?", back: "1692 series of hearings and prosecutions of people accused of witchcraft in Salem, Massachusetts (20 executed)" },
      { front: "What was the Great Awakening?", back: "A series of Christian revivals in the 1730s-1740s that swept the colonies, emphasizing personal religious experience" },
      { front: "What was the Navigation Acts?", back: "Laws passed by Britain (1651-1765) restricting colonial trade to benefit the mother country" },
      { front: "What was the French and Indian War?", back: "1754-1763 conflict between Britain and France (with Native American allies) for control of North America" },
      { front: "What was the Proclamation of 1763?", back: "British decree forbidding colonial settlement west of the Appalachian Mountains" },
      { front: "What was the Stamp Act?", back: "1765 tax on printed materials in the colonies; sparked protests and 'No taxation without representation'" },
      { front: "What was the Boston Massacre?", back: "1770 confrontation in which British soldiers killed five colonists; used as propaganda for independence" },
      { front: "What was the Boston Tea Party?", back: "1773 protest where colonists dumped 342 chests of tea into Boston Harbor to protest the Tea Act" },
      { front: "What were the Intolerable Acts?", back: "1774 British laws punishing Massachusetts for the Tea Party; closed Boston Harbor and restricted self-governance" },
      { front: "What was the First Continental Congress?", back: "1772 meeting of delegates from 12 colonies to coordinate a response to the Intolerable Acts" },
      { front: "When was the Declaration of Independence signed?", back: "July 4, 1776 - declaring the 13 colonies independent from Britain" },
      { front: "Who wrote the Declaration of Independence?", back: "Thomas Jefferson, with contributions from Benjamin Franklin, John Adams, and others" },
      { front: "What was the primary purpose of colonial education?", back: "To train clergy and civic leaders; Harvard (1636) was the first colonial college" },
      { front: "What was indentured servitude?", back: "A system where people worked for a set number of years (typically 4-7) in exchange for passage to America" },
      { front: "What was the triangular trade?", back: "A trade route between Europe, Africa, and the Americas involving goods, enslaved people, and raw materials" },
      { front: "What was the significance of the Quebec Act?", back: "1774 act extending Quebec's boundaries and granting religious freedom to Catholics; angered American colonists" },
      { front: "What was the role of Committees of Correspondence?", back: "Communication networks established by colonial patriots to coordinate resistance against British policies" },
    ],
  },
  {
    title: "Spanish Basics - Common Phrases",
    subject: "English",
    description: "Essential Spanish phrases for beginners",
    cards: [
      { front: "Hello / Hi", back: "Hola" },
      { front: "Good morning", back: "Buenos días" },
      { front: "Good afternoon", back: "Buenas tardes" },
      { front: "Good night", back: "Buenas noches" },
      { front: "How are you?", back: "¿Cómo estás?" },
      { front: "I'm fine, thank you", back: "Estoy bien, gracias" },
      { front: "What is your name?", back: "¿Cómo te llamas?" },
      { front: "My name is...", back: "Me llamo..." },
      { front: "Nice to meet you", back: "Mucho gusto" },
      { front: "Please", back: "Por favor" },
      { front: "Thank you", back: "Gracias" },
      { front: "You're welcome", back: "De nada" },
      { front: "I'm sorry", back: "Lo siento" },
      { front: "Excuse me", back: "Disculpe" },
      { front: "Yes / No", back: "Sí / No" },
      { front: "I don't understand", back: "No entiendo" },
      { front: "Do you speak English?", back: "¿Hablas inglés?" },
      { front: "How much does it cost?", back: "¿Cuánto cuesta?" },
      { front: "Where is the bathroom?", back: "¿Dónde está el baño?" },
      { front: "I would like...", back: "Me gustaría..." },
    ],
  },
  {
    title: "Computer Science - Data Structures",
    subject: "Computer Science",
    description: "Fundamental data structures and their properties",
    cards: [
      { front: "What is an array?", back: "A collection of elements stored at contiguous memory locations, accessed by index. O(1) access time." },
      { front: "What is a linked list?", back: "A linear data structure where elements (nodes) are stored in non-contiguous memory, each pointing to the next. O(n) access." },
      { front: "What is a stack?", back: "A LIFO (Last In, First Out) data structure. Push adds to top, pop removes from top. O(1) operations." },
      { front: "What is a queue?", back: "A FIFO (First In, First Out) data structure. Enqueue adds to back, dequeue removes from front. O(1) operations." },
      { front: "What is a hash table?", back: "A key-value store using a hash function to compute an index into an array of buckets. Average O(1) lookup." },
      { front: "What is a binary tree?", back: "A tree data structure where each node has at most two children (left and right)." },
      { front: "What is a binary search tree (BST)?", back: "A binary tree where left child < parent < right child. Enables O(log n) search, insert, and delete." },
      { front: "What is a heap?", back: "A complete binary tree where the parent is always >= (max-heap) or <= (min-heap) its children." },
      { front: "What is a graph?", back: "A collection of vertices (nodes) connected by edges. Can be directed or undirected, weighted or unweighted." },
      { front: "What is Big-O notation?", back: "Describes the upper bound of an algorithm's time/space complexity as input grows (e.g., O(n), O(log n), O(n²))" },
      { front: "What is BFS?", back: "Breadth-First Search: explores all neighbors at the present depth before moving deeper. Uses a queue." },
      { front: "What is DFS?", back: "Depth-First Search: explores as far as possible along each branch before backtracking. Uses a stack or recursion." },
      { front: "What is a hash collision?", back: "When two different keys produce the same hash index. Resolved by chaining or open addressing." },
      { front: "What is sorting?", back: "Arranging elements in a specific order. Common algorithms: bubble sort O(n²), merge sort O(n log n), quicksort O(n log n) avg." },
      { front: "What is recursion?", back: "A function that calls itself with a smaller input until reaching a base case." },
      { front: "What is a queue used for in BFS?", back: "To track the order of nodes to visit, ensuring level-by-level traversal." },
      { front: "What is a stack used for in DFS?", back: "To track the path of visited nodes, enabling backtracking when a dead end is reached." },
      { front: "What is dynamic programming?", back: "An optimization technique that solves complex problems by breaking them into overlapping subproblems and storing results." },
      { front: "What is memoization?", back: "Storing the results of expensive function calls and returning the cached result when the same inputs occur again." },
      { front: "What is a trie?", back: "A tree-like data structure used for efficient retrieval of keys in a dataset of strings, commonly used for autocomplete." },
    ],
  },
  {
    title: "Mathematics - Calculus Basics",
    subject: "Mathematics",
    description: "Fundamental calculus concepts and derivatives",
    cards: [
      { front: "What is a limit?", back: "The value that a function approaches as the input approaches some value. Written as lim(x→a) f(x) = L" },
      { front: "What is a derivative?", back: "The rate of change of a function with respect to its variable. f'(x) = lim(h→0) [f(x+h) - f(x)] / h" },
      { front: "What is the Power Rule?", back: "d/dx [xⁿ] = nxⁿ⁻¹. The derivative of x raised to a power." },
      { front: "What is the Chain Rule?", back: "d/dx [f(g(x))] = f'(g(x)) · g'(x). Differentiate the outer function, then multiply by the derivative of the inner." },
      { front: "What is the Product Rule?", back: "d/dx [f·g] = f'g + fg'. The derivative of a product of two functions." },
      { front: "What is the Quotient Rule?", back: "d/dx [f/g] = (f'g - fg') / g². The derivative of a division of two functions." },
      { front: "What is an integral?", back: "The reverse of differentiation; represents the area under a curve. ∫f(x)dx = F(x) + C" },
      { front: "What is the Fundamental Theorem of Calculus?", back: "Links differentiation and integration: ∫[a,b] f(x)dx = F(b) - F(a)" },
      { front: "What is continuity?", back: "A function is continuous at x=a if: f(a) exists, lim(x→a) f(x) exists, and lim(x→a) f(x) = f(a)" },
      { front: "What is the derivative of sin(x)?", back: "cos(x)" },
      { front: "What is the derivative of cos(x)?", back: "-sin(x)" },
      { front: "What is the derivative of eˣ?", back: "eˣ (it is its own derivative)" },
      { front: "What is the derivative of ln(x)?", back: "1/x" },
      { front: "What is a critical point?", back: "A point where f'(x) = 0 or f'(x) is undefined. Candidates for local maxima or minima." },
      { front: "What is the Mean Value Theorem?", back: "If f is continuous on [a,b] and differentiable on (a,b), there exists c in (a,b) where f'(c) = [f(b)-f(a)]/(b-a)" },
      { front: "What is an antiderivative?", back: "A function F(x) such that F'(x) = f(x). Also called the indefinite integral." },
      { front: "What is integration by substitution?", back: "The reverse of the chain rule. Let u = g(x), then du = g'(x)dx to simplify the integral." },
      { front: "What is the derivative of tan(x)?", back: "sec²(x)" },
      { front: "What is a limit from the left vs right?", back: "Left-hand limit: x approaches a from values less than a. Right-hand limit: x approaches a from values greater than a." },
      { front: "What is L'Hôpital's Rule?", back: "If a limit produces 0/0 or ∞/∞, then lim f(x)/g(x) = lim f'(x)/g'(x)" },
    ],
  },
  {
    title: "Psychology 101 - Foundations",
    subject: "Psychology",
    description: "Introduction to psychology key concepts",
    cards: [
      { front: "What is psychology?", back: "The scientific study of behavior and mental processes" },
      { front: "Who is the father of psychoanalysis?", back: "Sigmund Freud - developed psychoanalytic theory emphasizing the unconscious mind" },
      { front: "What is classical conditioning?", back: "Learning through association, where a neutral stimulus becomes paired with an unconditioned stimulus (Pavlov's dogs)" },
      { front: "What is operant conditioning?", back: "Learning through consequences - behavior is shaped by reinforcement (positive/negative) or punishment (Skinner)" },
      { front: "What is the id, ego, and superego?", back: "Freud's model: Id (primal desires), Ego (reality principle), Superego (morality/conscience)" },
      { front: "What is cognitive dissonance?", back: "The mental discomfort from holding two contradictory beliefs, leading to attitude change to reduce discomfort" },
      { front: "What is Maslow's hierarchy of needs?", back: "A pyramid of needs: physiological → safety → love/belonging → esteem → self-actualization" },
      { front: "What is the Stanford Prison Experiment?", back: "1971 study by Zimbardo where participants assigned as guards became authoritarian; stopped after 6 days due to abuse" },
      { front: "What is the Milgram experiment?", back: "1963 study showing that 65% of participants obeyed orders to administer what they believed were lethal electric shocks" },
      { front: "What is the placebo effect?", back: "A beneficial effect produced by a placebo drug or treatment, which cannot be attributed to the treatment itself" },
      { front: "What is neuroplasticity?", back: "The brain's ability to reorganize itself by forming new neural connections throughout life" },
      { front: "What is the fight-or-flight response?", back: "The body's acute stress response, triggered by adrenaline and cortisol, preparing for danger" },
      { front: "What is confirmation bias?", back: "The tendency to search for and favor information that confirms pre-existing beliefs" },
      { front: "What is a phobia?", back: "An intense, irrational fear of a specific object or situation that leads to avoidance behavior" },
      { front: "What is the self-fulfilling prophecy?", back: "A prediction that directly or indirectly causes itself to become true due to behavior confirming the belief" },
      { front: "What is positive reinforcement?", back: "Adding a pleasant stimulus after a behavior to increase the likelihood of that behavior recurring" },
      { front: "What is negative reinforcement?", back: "Removing an unpleasant stimulus after a behavior to increase the likelihood of that behavior recurring" },
      { front: "What isBandura's Social Learning Theory?", back: "People learn through observation, imitation, and modeling (Bobo doll experiment)" },
      { front: "What is the bystander effect?", back: "The phenomenon where individuals are less likely to help a victim when other people are present" },
      { front: "What is short-term/working memory?", back: "The brain's system for temporarily holding and manipulating information (capacity: ~7 items, duration: ~20 seconds)" },
    ],
  },
  {
    title: "Economics 101 - Microeconomics",
    subject: "Computer Science",
    description: "Core microeconomics principles",
    cards: [
      { front: "What is supply and demand?", back: "Supply: quantity producers offer at various prices. Demand: quantity consumers want at various prices. Equilibrium is where they meet." },
      { front: "What is opportunity cost?", back: "The value of the next best alternative given up when making a choice" },
      { front: "What is elasticity?", back: "A measure of how much quantity demanded/supplied changes in response to a price change" },
      { front: "What is a perfectly competitive market?", back: "Many buyers and sellers, identical products, no barriers to entry, perfect information" },
      { front: "What is a monopoly?", back: "A single seller dominating the market with no close substitutes and high barriers to entry" },
      { front: "What is marginal utility?", back: "The additional satisfaction gained from consuming one more unit of a good" },
      { front: "What is the law of diminishing returns?", back: "As you add more of one input while holding others constant, the marginal output eventually decreases" },
      { front: "What is GDP?", back: "Gross Domestic Product - the total market value of all final goods and services produced within a country in a period" },
      { front: "What is inflation?", back: "A general increase in prices over time, reducing the purchasing power of money" },
      { front: "What is a tariff?", back: "A tax imposed on imported goods to protect domestic industries and generate revenue" },
      { front: "What is a subsidy?", back: "A government payment to producers to encourage production or reduce consumer prices" },
      { front: "What is the difference between fixed and variable costs?", back: "Fixed costs don't change with output (rent). Variable costs change with output (materials, labor)." },
      { front: "What is deadweight loss?", back: "The loss of economic efficiency when equilibrium is not achieved (from taxes, monopolies, etc.)" },
      { front: "What is comparative advantage?", back: "The ability to produce a good at a lower opportunity cost than another producer" },
      { front: "What is a normal good?", back: "A good for which demand increases as consumer income increases" },
      { front: "What is an inferior good?", back: "A good for which demand decreases as consumer income increases (e.g., instant noodles)" },
      { front: "What is economies of scale?", back: "Cost advantages gained by increased production (average cost per unit decreases as output increases)" },
      { front: "What is a price ceiling?", back: "A government-imposed maximum price, set below equilibrium (e.g., rent control). Can cause shortages." },
      { front: "What is a price floor?", back: "A government-imposed minimum price, set above equilibrium (e.g., minimum wage). Can cause surpluses." },
      { front: "What is the Cobb-Douglas production function?", back: "Y = A·Lᵅ·Kᵝ: models output as a function of labor (L) and capital (K) with productivity parameter A" },
    ],
  },
  {
    title: "English Literature - Shakespeare",
    subject: "English",
    description: "Key Shakespeare works, characters, and terms",
    cards: [
      { front: "Who wrote Romeo and Juliet?", back: "William Shakespeare, written around 1594-1596" },
      { front: "What is a soliloquy?", back: "A speech given by a character alone on stage, revealing their inner thoughts (e.g., Hamlet's 'To be or not to be')" },
      { front: "What is iambic pentameter?", back: "A metrical pattern of 10 syllables per line with alternating unstressed and stressed syllables (da-DUM x5)" },
      { front: "Who is the protagonist of Hamlet?", back: "Prince Hamlet of Denmark, who seeks to avenge his father's murder" },
      { front: "What is the tragedy in Macbeth?", back: "Macbeth's unchecked ambition and murder of King Duncan lead to his downfall and death" },
      { front: "What does 'All the world's a stage' mean?", back: "From As You Like It - comparing life to a play where people play different roles at different ages" },
      { front: "Who is the villain in Othello?", back: "Iago, who manipulates Othello into believing his wife Desdemona is unfaithful" },
      { front: "What is a sonnet?", back: "A 14-line poem with a specific rhyme scheme. Shakespeare's sonnets use the ABAB CDCD EFEF GG scheme." },
      { front: "What is dramatic irony?", back: "When the audience knows something the characters don't (e.g., audience knows Romeo thinks Juliet is dead)" },
      { front: "What is A Midsummer Night's Dream about?", back: "A comedic play where fairies interfere with the romantic lives of Athenian lovers in an enchanted forest" },
      { front: "What is the Globe Theatre?", back: "Shakespeare's famous open-air theatre in London, built in 1599, where many of his plays were first performed" },
      { front: "What is a foil character?", back: "A character who contrasts with another to highlight particular qualities (e.g., Laertes is a foil to Hamlet)" },
      { front: "What is the theme of power in Macbeth?", back: "Power corrupts; Macbeth's lust for power leads to moral decay, madness, and ultimately destruction" },
      { front: "What is blank verse?", back: "Unrhymed iambic pentameter - the most common form Shakespeare used for dialogue" },
      { front: "Who is Puck in A Midsummer Night's Dream?", back: "A mischievous fairy who creates chaos by using a love potion on the wrong people" },
      { front: "What is the meaning of 'Et tu, Brute?'", back: "Caesar's last words in Julius Caesar, expressing shock at Brutus's betrayal" },
      { front: "What is a comedy in Shakespeare's terms?", back: "A play that ends happily, often with marriages and reconciliation (e.g., Twelfth Night, Much Ado About Nothing)" },
      { front: "What is The Tempest about?", back: "Prospero, a exiled duke, uses magic on an island to restore his position and reconcile with his enemies" },
      { front: "What is Shakespeare's most performed play?", back: "Hamlet is often cited as the most performed and adapted of Shakespeare's works" },
      { front: "What is a Shakespearean tragedy?", back: "A serious play with an unhappy ending, typically involving the downfall of a noble protagonist (Hamlet, Macbeth, Lear, Othello)" },
    ],
  },
  {
    title: "Geography - World Capitals",
    subject: "Geography",
    description: "Essential world capitals and countries",
    cards: [
      { front: "Capital of Japan?", back: "Tokyo" },
      { front: "Capital of Australia?", back: "Canberra (not Sydney!)" },
      { front: "Capital of Brazil?", back: "Brasília (not Rio de Janeiro!)" },
      { front: "Capital of Canada?", back: "Ottawa (not Toronto!)" },
      { front: "Capital of India?", back: "New Delhi" },
      { front: "Capital of Egypt?", back: "Cairo" },
      { front: "Capital of South Korea?", back: "Seoul" },
      { front: "Capital of Turkey?", back: "Ankara (not Istanbul!)" },
      { front: "Capital of South Africa?", back: "Pretoria (administrative), Cape Town (legislative), Bloemfontein (judicial)" },
      { front: "Capital of China?", back: "Beijing" },
      { front: "Capital of Russia?", back: "Moscow" },
      { front: "Capital of Germany?", back: "Berlin" },
      { front: "Capital of France?", back: "Paris" },
      { front: "Capital of the United Kingdom?", back: "London" },
      { front: "Capital of Mexico?", back: "Mexico City" },
      { front: "Capital of Argentina?", back: "Buenos Aires" },
      { front: "Capital of Thailand?", back: "Bangkok" },
      { front: "Capital of Kenya?", back: "Nairobi" },
      { front: "Capital of Saudi Arabia?", back: "Riyadh" },
      { front: "Capital of New Zealand?", back: "Wellington (not Auckland!)" },
    ],
  },
  {
    title: "Philosophy 101 - Key Thinkers",
    subject: "Psychology",
    description: "Major philosophers and their ideas",
    cards: [
      { front: "Who said 'I think, therefore I am'?", back: "René Descartes - the foundational statement of his existence as a thinking being (Cogito ergo sum)" },
      { front: "What is Plato's Allegory of the Cave?", back: "Prisoners see only shadows on a wall and think they represent reality; represents the journey from ignorance to enlightenment" },
      { front: "What is Aristotle's Ethics about?", back: "Virtue ethics - the pursuit of eudaimonia (flourishing) through the practice of virtues (the 'golden mean')" },
      { front: "What is Kant's Categorical Imperative?", back: "Act only according to rules you could will to be universal laws; treat people as ends, never merely as means" },
      { front: "What is utilitarianism?", back: "The greatest good for the greatest number. Actions are right if they maximize overall happiness (Bentham, Mill)." },
      { front: "What is Nietzsche's 'Will to Power'?", back: "The fundamental drive of all living things to assert and enhance their strength and creativity" },
      { front: "Who wrote 'The Republic'?", back: "Plato - a dialogue about justice, the ideal state, and the philosopher-king" },
      { front: "What is existentialism?", back: "A philosophy emphasizing individual freedom, responsibility, and the search for meaning (Sartre, Camus, Kierkegaard)" },
      { front: "What is the 'Veil of Ignorance'?", back: "John Rawls' thought experiment: design a just society without knowing your own position in it" },
      { front: "What is Descartes' 'Method of Doubt'?", back: "Systematically doubting everything that can be doubted to find what is certainly true" },
      { front: "What is the 'state of nature'?", back: "A hypothetical condition before government/society (Hobbes: war of all; Locke: natural rights; Rousseau: noble savage)" },
      { front: "What is Socrates' method?", back: "The Socratic method - questioning to expose contradictions and arrive at deeper understanding (elenchus)" },
      { front: "What is Stoicism?", back: "A philosophy of virtue and rationality, accepting what you cannot control (Epictetus, Marcus Aurelius, Seneca)" },
      { front: "What is Epicureanism?", back: "The pursuit of pleasure through simple living, friendship, and absence of fear (not hedonism as commonly thought)" },
      { front: "What is the 'trolley problem'?", back: "An ethical dilemma: do you redirect a trolley to kill 1 person instead of 5? Tests utilitarian vs deontological ethics" },
      { front: "Who wrote 'The Social Contract'?", back: "Jean-Jacques Rousseau - arguing legitimate government is based on the consent of the governed" },
      { front: "What is Camus' 'The Myth of Sisyphus'?", back: "The idea that we must imagine Sisyphus happy despite his absurd task; embracing the absurd gives life meaning" },
      { front: "What is Hegel's dialectic?", back: "Thesis → Antithesis → Synthesis: progress through the resolution of contradictions" },
      { front: "What is 'Occam's Razor'?", back: "The principle that the simplest explanation that accounts for all the facts is preferred" },
      { front: "What is the Ship of Theseus paradox?", back: "If you replace every plank of a ship one by one, is it still the same ship? Questions identity and persistence." },
    ],
  },
];

const GUIDES: {
  title: string;
  subject: Subject;
  content: string;
}[] = [
  {
    title: "Biology 101 - Complete Study Guide",
    subject: "Biology",
    content: `# Biology 101 - Complete Study Guide

## Chapter 1: Cell Biology
Cells are the basic unit of life. All living organisms are made of cells.

### Prokaryotic vs Eukaryotic Cells
- **Prokaryotes**: No nucleus, no membrane-bound organelles (bacteria, archaea)
- **Eukaryotes**: Have a nucleus and membrane-bound organelles (plants, animals, fungi)

### Key Organelles
- Nucleus: Contains DNA, controls cell activities
- Mitochondria: Cellular respiration, ATP production ("powerhouse")
- Ribosomes: Protein synthesis
- ER (Rough): Protein modification with ribosomes
- ER (Smooth): Lipid synthesis, detoxification
- Golgi Apparatus: Package and ship proteins
- Lysosomes: Digest cellular waste
- Cell Membrane: Phospholipid bilayer, selectively permeable

## Chapter 2: Genetics
### DNA Structure
- Double helix structure
- Nucleotides: sugar + phosphate + base (A, T, G, C)
- Base pairing: A-T, G-C

### Protein Synthesis
1. **Transcription**: DNA → mRNA (in nucleus)
2. **Translation**: mRNA → Protein (at ribosomes)

### Mendelian Genetics
- Dominant alleles (A) mask recessive (a)
- Genotype: AA, Aa, aa
- Phenotype: Physical appearance
- Punnett squares predict offspring ratios

## Chapter 3: Evolution
- Natural selection: survival of the fittest
- Genetic drift: random changes in small populations
- Speciation: formation of new species
- Evidence: fossil record, DNA similarities, vestigial structures

## Chapter 4: Ecology
- Ecosystems: communities of organisms + environment
- Food chains: producer → primary consumer → secondary consumer → decomposer
- Biogeochemical cycles: carbon, nitrogen, water
- Biodiversity: variety of life in an ecosystem`,
  },
  {
    title: "Physics Formula Sheet",
    subject: "Physics",
    content: `# Physics Formula Sheet - Mechanics

## Kinematics (Constant Acceleration)
- v = v₀ + at
- x = x₀ + v₀t + ½at²
- v² = v₀² + 2a(x - x₀)

## Newton's Laws
1. An object at rest stays at rest; in motion stays in motion (unless acted upon)
2. F = ma
3. F_AB = -F_BA

## Energy
- Kinetic Energy: KE = ½mv²
- Potential Energy: PE = mgh
- Elastic PE: PE = ½kx²
- Work: W = Fd cos(θ)
- Power: P = W/t = Fv

## Momentum
- p = mv
- Impulse: J = FΔt = Δp
- Conservation: m₁v₁ + m₂v₂ = m₁v₁' + m₂v₂'

## Rotational Motion
- Torque: τ = rF sin(θ)
- Angular velocity: ω = Δθ/Δt
- Moment of inertia: I = Σmr²

## Simple Harmonic Motion
- Period: T = 2π√(m/k)
- Frequency: f = 1/T

## Gravitational
- F = Gm₁m₂/r²
- G = 6.67 × 10⁻¹¹ N⋅m²/kg²

## Important Constants
- g = 9.8 m/s² (acceleration due to gravity)
- c = 3 × 10⁸ m/s (speed of light)`,
  },
  {
    title: "Spanish Verb Conjugation Guide",
    subject: "English",
    content: `# Spanish Verb Conjugation Guide

## Regular -AR Verbs (Hablar - to speak)
| Person | Present | Preterite | Imperfect |
|--------|---------|-----------|-----------|
| Yo | hablo | hablé | hablaba |
| Tú | hablas | hablaste | hablabas |
| Él/Ella | habla | habló | hablaba |
| Nosotros | hablamos | hablamos | hablábamos |
| Vosotros | habláis | hablasteis | hablabais |
| Ellos | hablan | hablaron | hablaban |

## Regular -ER Verbs (Comer - to eat)
| Person | Present | Preterite |
|--------|---------|-----------|
| Yo | como | comí |
| Tú | comes | comiste |
| Él/Ella | come | comió |
| Nosotros | comemos | comimos |

## Regular -IR Verbs (Vivir - to live)
| Person | Present | Preterite |
|--------|---------|-----------|
| Yo | vivo | viví |
| Tú | vives | viviste |
| Él/Ella | vive | vivió |
| Nosotros | vivimos | vivimos |

## Common Irregular Verbs
- Ser (to be - identity): soy, eres, es, somos, sois, son
- Estar (to be - location): estoy, estás, está, estamos, estáis, están
- Tener (to have): tengo, tienes, tiene, tenemos, tenéis, tienen
- Ir (to go): voy, vas, va, vamos, vais, van
- Hacer (to do/make): hago, haces, hace, hacemos, hacéis, hacen

## Ser vs Estar
- **Ser**: Identity, characteristics, time, origin
- **Estar**: Location, emotions, conditions, progressive tenses`,
  },
];

function SeedInner() {
  const [secret] = useState(() => {
    if (typeof window !== "undefined") {
      return new URLSearchParams(window.location.search).get("secret");
    }
    return null;
  });
  const { user, loading: authLoading } = useAuth();
  const supabase = createClient();
  const [status, setStatus] = useState<"idle" | "loading" | "done" | "error">(
    "idle"
  );
  const [message, setMessage] = useState("");
  const [progress, setProgress] = useState(0);

  if (secret === null) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  if (secret !== "studyswap") {
    return (
      <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4 px-4">
        <Lock className="h-12 w-12 text-gray-400" />
        <h1 className="text-xl font-bold text-gray-900">Access Denied</h1>
        <p className="text-sm text-gray-500">This page is restricted.</p>
        <Link href="/" className="text-sm text-primary hover:underline">
          Go home
        </Link>
      </div>
    );
  }

  const handleSeed = async () => {
    if (!user) return;
    setStatus("loading");
    setProgress(0);

    try {
      const totalSteps = DECKS.length + GUIDES.length;
      let currentStep = 0;

      for (const deck of DECKS) {
        const { data: newDeck, error: deckErr } = await supabase
          .from("decks")
          .insert({
            user_id: user.id,
            title: deck.title,
            description: deck.description,
            subject: deck.subject,
            card_count: deck.cards.length,
            upvotes: Math.floor(Math.random() * 30) + 5,
          })
          .select()
          .single();

        if (deckErr) throw deckErr;

        const cardInserts = deck.cards.map((card, i) => ({
          deck_id: newDeck.id,
          front: card.front,
          back: card.back,
          position: i,
        }));

        const { error: cardsErr } = await supabase
          .from("cards")
          .insert(cardInserts);

        if (cardsErr) throw cardsErr;

        currentStep++;
        setProgress(Math.round((currentStep / totalSteps) * 100));
      }

      for (const guide of GUIDES) {
        const { error } = await supabase.from("study_guides").insert({
          user_id: user.id,
          title: guide.title,
          subject: guide.subject,
          content: guide.content,
          upvotes: Math.floor(Math.random() * 25) + 3,
        });

        if (error) throw error;

        currentStep++;
        setProgress(Math.round((currentStep / totalSteps) * 100));
      }

      setStatus("done");
      setMessage(
        `Successfully seeded ${DECKS.length} decks with ${DECKS.reduce((a, d) => a + d.cards.length, 0)} total cards and ${GUIDES.length} study guides!`
      );
    } catch (err: unknown) {
      setStatus("error");
      setMessage(err instanceof Error ? err.message : "Unknown error");
    }
  };

  if (authLoading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4">
        <p className="text-gray-500">Please log in first to seed the database.</p>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-16">
      <div className="rounded-2xl border border-gray-200 bg-white p-8 shadow-sm text-center">
        <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-primary/10 text-primary">
          <Database className="h-8 w-8" />
        </div>
        <h1 className="mt-6 text-2xl font-bold text-gray-900">
          Seed Study Materials
        </h1>
        <p className="mt-2 text-gray-500">
          Populate the platform with {DECKS.length} flashcard decks (
          {DECKS.reduce((a, d) => a + d.cards.length, 0)} cards) and{" "}
          {GUIDES.length} study guides across all subjects.
        </p>

        {status === "idle" && (
          <button
            onClick={handleSeed}
            className="mt-8 rounded-xl bg-primary px-6 py-3 text-base font-semibold text-white hover:bg-primary-hover transition-colors"
          >
            Seed Database
          </button>
        )}

        {status === "loading" && (
          <div className="mt-8">
            <div className="mb-2 h-3 overflow-hidden rounded-full bg-gray-200">
              <div
                className="h-full rounded-full bg-primary transition-all duration-300"
                style={{ width: `${progress}%` }}
              />
            </div>
            <p className="text-sm text-gray-500">{progress}% complete</p>
          </div>
        )}

        {status === "done" && (
          <div className="mt-8 rounded-lg bg-green-50 p-4">
            <div className="flex items-center gap-2 text-green-700">
              <CheckCircle className="h-5 w-5" />
              <p className="font-medium">{message}</p>
            </div>
            <a
              href="/explore"
              className="mt-4 inline-block text-sm font-medium text-primary hover:underline"
            >
              Go to Explore →
            </a>
          </div>
        )}

        {status === "error" && (
          <div className="mt-8 rounded-lg bg-red-50 p-4">
            <div className="flex items-center gap-2 text-red-600">
              <AlertCircle className="h-5 w-5" />
              <p className="font-medium">{message}</p>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default function SeedContent() {
  return <SeedInner />;
}
