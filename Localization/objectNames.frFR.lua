-- Please use the Localization App on WoWAce to Update this
-- https://wow.curseforge.com/projects/wowgatheringnodes/localization

if GetLocale() ~= frFR then return; end
local WoWGatheringNodes = LibStub("AceAddon-3.0"):GetAddon("WoWGatheringNodes")
local L = LibStub("AceLocale-3.0"):NewLocale("WoWGatheringNodes", "frFR")
if not L then return end

--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="comment")@

WoWGatheringNodes.NodeIdNames = {
	[181069] =  "Grand morceau d'obsidienne",
	[2040] =  "Gisement de mithril",
	[2041] =  "Vietérule",
	[209330] =  "Riche filon de trillium",
	[2043] =  "Moustache de Khadgar",
	[2044] =  "Dents de dragon",
	[2045] =  "Etouffante",
	[2046] =  "Dorépine",
	[2047] =  "Gisement de vrai-argent",
	[201914] =  "Feuillelune",
	[216620] =  "Houblon de la jungle",
	[182606] =  "Epine-de-dragon",
	[218539] =  "Grande colonie de poulpes des récifs migrants",
	[209460] =  "Canne en rotin",
	[233117] =  "Givrelette",
	[182095] =  "Champignon Tête-tonnante",
	[188489] =  "Lilas rubis",
	[2084] =  "Racine de Musquash",
	[209461] =  "Canne en rotin",
	[123848] =  "Filon de thorium couvert de limon",
	[208311] =  "Banc de sagerelles abyssales",
	[209462] =  "Canne en rotin",
	[247697] =  "Affleurement de gangreschiste odieux",
	[209974] =  "Tonneau de poisseux",
	[209463] =  "Canne en rotin",
	[247698] =  "Veine de gangreschiste brisé",
	[253069] =  "Lotus encore plus noir",
	[247699] =  "Gisement de gangreschiste primordial",
	[246804] =  "Trouvaille archéologique taurène de Haut-Roc",
	[203071] =  "Trouvaille archéologique elfe de la nuit",
	[208442] =  "Vrillebleue",
	[237342] =  "Bassin de piranhas sauvages",
	[190540] =  "Morceau de saronite",
	[247956] =  "Noyau de destructeur de soufre",
	[247957] =  "Noyau de destructeur de soufre",
	[273412] =  "Ancienne cache érédar",
	[208828] =  "Tas de vers de cadavre",
	[203969] =  "Figue de Barbarie",
	[13891] =  "Fleur de serpent",
	[188113] =  "Buisson de givrelles",
	[273415] =  "Ancienne cache érédar",
	[247959] =  "Noyau de destructeur de soufre",
	[3239] =  "Coffre de Benedict",
	[247960] =  "Noyau de destructeur de soufre",
	[260492] =  "Tome chatoyant",
	[247961] =  "Noyau de destructeur de soufre",
	[260493] =  "Gemme imprégnée de mana",
	[211517] =  "Recroquevrille",
	[183385] =  "Hibiscus sanguin",
	[247962] =  "Noyau de destructeur de soufre",
	[203078] =  "Trouvaille archéologique nérubienne",
	[260494] =  "Liqueur d’arquevin",
	[211518] =  "Recroquevrille",
	[216761] =  "Banc de poissons océaniques",
	[208833] =  "Lys d’eau",
	[246812] =  "Trouvaille archéologique démoniaque",
	[247963] =  "Noyau de destructeur de soufre",
	[184793] =  "Coffre primitif",
	[247964] =  "Noyau de destructeur de soufre",
	[234154] =  "Parchemins égarés",
	[247965] =  "Noyau de destructeur de soufre",
	[234155] =  "Reliques des parias",
	[209987] =  "Buisson de songefeuilles",
	[247966] =  "Noyau de destructeur de soufre",
	[260498] =  "Fleur de telluréclat",
	[247967] =  "Noyau de destructeur de soufre",
	[209349] =  "Feuille de thé vert",
	[211779] =  "Saule mao",
	[175207] =  "Créature marine échouée",
	[212163] =  "Banc de saumons empereurs",
	[209350] =  "Herbe à soie",
	[190169] =  "Lys tigré",
	[185182] =  "Cristal vignéant",
	[247969] =  "Noyau de destructeur de soufre",
	[209351] =  "Lys des neiges",
	[190170] =  "Rose de Talandra",
	[202702] =  "Pierrelette",
	[247075] =  "Boule de cire secrétée",
	[190171] =  "Fleur-de-liche",
	[237357] =  "Riche gisement de vérifer",
	[202703] =  "Amertine",
	[186463] =  "Queue de wyrm",
	[203982] =  "Okra",
	[209353] =  "Pavot de pluie",
	[190172] =  "Glacépine",
	[237358] =  "Gisement de vérifer",
	[244775] =  "Songefeuille",
	[209354] =  "Lotus doré",
	[17282] =  "Cheveux de Bathran",
	[190173] =  "Herbe gelée",
	[237359] =  "Gisement de rochenoire",
	[244776] =  "Songefeuille",
	[209355] =  "Berluette",
	[237360] =  "Riche gisement de rochenoire",
	[244777] =  "Fjarnskaggl",
	[212169] =  "Banc de crevettes-mantes géantes",
	[225596] =  "Nopal épineux",
	[180712] =  "Banc d'anguilles pierre-écaille",
	[190175] =  "Herbe gelée",
	[244778] =  "Rose lumétoile",
	[177388] =  "Riche filon de thorium couvert de limon",
	[190176] =  "Lotus givré",
	[212171] =  "Banc de dipneustes de jade",
	[195036] =  "Gisement de saronite pure",
	[212172] =  "Banc de poissons-spatules de Krasarang",
	[218950] =  "Trouvaille archéologique mantide",
	[212174] =  "Banc de poulpes des récifs",
	[207187] =  "Trouvaille archéologique orque",
	[247340] =  "Veine de tellurium basique",
	[212175] =  "Banc de gouramis tigres",
	[207188] =  "Trouvaille archéologique draeneï",
	[211025] =  "Orchidée feu-doré",
	[186729] =  "Buisson à baies de mana",
	[212177] =  "Banc de poissons-hérissons",
	[207190] =  "Trouvaille archéologique tol'vir",
	[182127] =  "Fleur corrompue",
	[244786] =  "Gangrèche",
	[251181] =  "Minerai azur",
	[203228] =  "Pyrite de fer des Mille pointes",
	[269887] =  "Touffe d’herbe incrustée de corruption",
	[181108] =  "Gisement de vrai-argent",
	[247987] =  "Veine de tellurium brillant",
	[184689] =  "Cristal de mine de draenéthyste",
	[218576] =  "Grand amas de crevettes-mantes enchevêtrées",
	[226888] =  "Buisson à baies d’Aruunem",
	[211160] =  "Œuf de grue en parfait état",
	[218577] =  "Amas de crevettes-mantes enchevêtrées",
	[247605] =  "Aethril florissant",
	[247989] =  "Veine de tellurium sauvage",
	[184691] =  "Tubercule d'Ombrelune",
	[141853] =  "Tragan pourpre",
	[247606] =  "Songefeuille florissante",
	[273222] =  "Fournitures de guerre érédars",
	[272455] =  "Fournitures de guerre érédars",
	[267596] =  "[Tar-Covered Fish]",
	[2714] =  "Granit d'Alterac",
	[272456] =  "Fournitures de guerre érédars",
	[211163] =  "Trouvaille archéologique pandarène",
	[247352] =  "Gisement de tellurium dur",
	[247608] =  "Rose lumétoile florissante",
	[241726] =  "Gisement de tellurium",
	[205538] =  "Racine de fétidelle épineuse",
	[247865] =  "Aethril aqueux",
	[229068] =  "Banc de dormeurs tachetés",
	[229069] =  "Banc d’esturgeons jaunes aveugles",
	[181372] =  "Atric des Flammes infernales",
	[229070] =  "Banc d’ammonites de feu",
	[229071] =  "Banc de scorpions de mer",
	[208867] =  "Pierres rutilantes",
	[184443] =  "Clochette d'ivoire",
	[74447] =  "Grand coffre cerclé de fer",
	[229072] =  "Banc de grangousiers des abysses",
	[229073] =  "Banc de hokis des flots noirs",
	[181248] =  "Filon de cuivre",
	[208997] =  "Fruit solaire éternel",
	[247999] =  "Gangrèche",
	[181249] =  "Filon d'étain",
	[248000] =  "Gangrèche",
	[2866] =  "Fleur de feu",
	[152094] =  "Champignon jacinthe",
	[211684] =  "Fleurs volatiles",
	[234446] =  "Reliques des parias",
	[208999] =  "Poire lunaire éternelle",
	[248001] =  "Gangrèche",
	[152095] =  "Lys pétale de lune",
	[211174] =  "Trouvaille archéologique mogu",
	[181891] =  "Champignon de sang",
	[248003] =  "Gangrèche",
	[187902] =  "Carpelle spore-sang",
	[181892] =  "Satyre puant aquatique",
	[268901] =  "Pointe de gangreschiste",
	[178184] =  "Saphir d’Aku’Mai",
	[248004] =  "Gangrèche",
	[181893] =  "Polypore des ruines",
	[207724] =  "Débris d’épave",
	[208875] =  "Pomme de pin de Mulgore",
	[248005] =  "Gangrèche",
	[247366] =  "Affleurement de tellurium imparfait",
	[234451] =  "Reliques des parias",
	[126049] =  "Champignons magenta",
	[248006] =  "Gangrèche",
	[210539] =  "Fleur éternelle",
	[203762] =  "Pomme juteuse",
	[248007] =  "Gangrèche",
	[202740] =  "Riche gisement de pyrite",
	[228571] =  "Givrelette",
	[221538] =  "Gisement d’ectofer",
	[181897] =  "Larme d'Ysera",
	[268911] =  "Sang de Sargeras",
	[234454] =  "Reliques des parias",
	[241743] =  "Gisement de gangreschiste",
	[228572] =  "Ignescente",
	[221539] =  "Riche gisement d’ectofer",
	[247370] =  "Noyau de destructeur de soufre",
	[165658] =  "Gisement de sombrefer",
	[206706] =  "Violette pleureuse",
	[234455] =  "Reliques des parias",
	[201975] =  "Goudronelle",
	[221540] =  "Riche filon de trillium",
	[207346] =  "Lys pétale de lune",
	[245325] =  "Riche gisement de gangreschiste",
	[273519] =  "Fournitures de guerre de la Légion",
	[248011] =  "Gangrèche",
	[181644] =  "Gueule-de-loup azurée",
	[237398] =  "Givrelette",
	[206836] =  "Trouvaille archéologique fossile",
	[273521] =  "Fournitures de guerre de la Légion",
	[248012] =  "Gangrèche",
	[221542] =  "Feuille de thé vert",
	[273523] =  "Fournitures de guerre de la Légion",
	[228576] =  "Orchidée de Talador",
	[221543] =  "Pavot de pluie",
	[180751] =  "Débris flottants",
	[273524] =  "Fournitures de guerre de la Légion",
	[205559] =  "Buisson de pourrielle",
	[237400] =  "Orchidée de Talador",
	[209907] =  "Souci des prés",
	[221544] =  "Herbe à soie",
	[204281] =  "Tas de vers",
	[207734] =  "Flaque de feu",
	[206839] =  "La Lumière des âmes",
	[232542] =  "Gisement de rochenoire",
	[221545] =  "Lotus doré",
	[204282] =  "Trouvaille archéologique naine",
	[273528] =  "Fournitures de guerre de la Légion",
	[237402] =  "Dionée de Gorgrond",
	[202748] =  "Vignétincelle",
	[232543] =  "Riche gisement de rochenoire",
	[202749] =  "Voile d'Azshara",
	[232544] =  "Gisement de vérifer",
	[248017] =  "Vulpille clairsemée",
	[221547] =  "Berluette",
	[237404] =  "Bourrache",
	[202750] =  "Pétale de cœur",
	[232545] =  "Riche gisement de vérifer",
	[248018] =  "Vulpille touffue",
	[221548] =  "Banc de danios joyaux",
	[240346] =  "Rameau d’olivier",
	[202751] =  "Jasmin crépusculaire",
	[273535] =  "Fournitures de guerre de la Légion",
	[272768] =  "Gisement d'empyrium",
	[221549] =  "[Redbelly Mandarin School]",
	[237406] =  "Sagittaire de Nagrand",
	[202752] =  "Fouettine",
	[248020] =  "Aethril iridescent",
	[11713] =  "Amanite phalloïde",
	[235105] =  "Cache touchée par le soleil",
	[142140] =  "Lotus pourpre",
	[181270] =  "Gangrelette",
	[142141] =  "Larmes d'Arthas",
	[188432] =  "Sang noir de Yogg-Saron",
	[248022] =  "Aethril touffu",
	[1610] =  "Filon d'incendicite",
	[142142] =  "Soleillette",
	[248023] =  "Songefeuille vivace",
	[1618] =  "Pacifique",
	[1619] =  "Terrestrine",
	[1620] =  "Mage royal",
	[142143] =  "Aveuglette",
	[171938] =  "Pomme de cactus",
	[1623] =  "Aciérite sauvage",
	[1624] =  "Sang-royal",
	[248024] =  "Songefeuille iridescente",
	[185877] =  "Gisement de néanticite",
	[1628] =  "Tombeline",
	[142144] =  "Champignon fantôme",
	[235365] =  "Coffre de l’amiral Taylor",
	[247897] =  "Fjarnskaggl roussi",
	[272780] =  "Veine d'empyrium",
	[142145] =  "Gromsang",
	[181275] =  "Voile-misère",
	[205060] =  "Enchevêtrement de peste",
	[211454] =  "Buisson de kafa’kota",
	[123310] =  "Gisement de mithril couvert de vase",
	[181276] =  "Chapeflamme",
	[248027] =  "Fjarnskaggl dru",
	[247388] =  "Vulpille florissante",
	[181277] =  "Terocône",
	[206085] =  "Herbe gelée",
	[189973] =  "Trèfle doré",
	[206597] =  "Caisse du Marteau du crépuscule",
	[181278] =  "Lichen ancien",
	[268440] =  "Trouvaille archéologique des Bien-nés",
	[248029] =  "Fjarnskaggl âcre",
	[181279] =  "Néantine",
	[248030] =  "Rose lumétoile vivace",
	[209284] =  "Pétales-de-nuit",
	[181280] =  "Cauchemardelle",
	[248031] =  "Rose lumétoile iridescente",
	[181281] =  "Chardon de mana",
	[247904] =  "Gisement de tellurium clair",
	[248032] =  "Rose lumétoile étincelante",
	[181665] =  "Coffre funéraire",
	[247905] =  "Gisement de tellurium chaud",
	[188699] =  "Minerai étrange",
	[273052] =  "Herbe incrustée de corruption",
	[189978] =  "Gisement de cobalt",
	[273053] =  "Touffe d’herbe incrustée de corruption",
	[247906] =  "Gisement de tellurium ardent",
	[179493] =  "Cantine moisie",
	[189979] =  "Riche gisement de cobalt",
	[268451] =  "Trouvaille archéologique démoniaque",
	[241641] =  "Vulpille",
	[247907] =  "Important gisement de tellurium",
	[179494] =  "Cantine abîmée",
	[189980] =  "Gisement de saronite",
	[268453] =  "Trouvaille archéologique des Bien-nés",
	[211719] =  "Cédrat pourpre",
	[235376] =  "Givrelette",
	[247908] =  "Gisement de tellurium luisant",
	[1723] =  "Fleur de fangemufle",
	[237295] =  "Banc de scorpions de mer huileux",
	[247909] =  "[Smooth Leystone Deposit]",
	[175404] =  "Riche filon de thorium",
	[253280] =  "Veine de tellurium",
	[1731] =  "Filon de cuivre",
	[1732] =  "Filon d'étain",
	[1733] =  "Filon d’argent",
	[243562] =  "Caisse de moustaches de Khadgar",
	[1735] =  "Gisement de fer",
	[247910] =  "Gisement de tellurium de qualité",
	[184740] =  "Coffre en osier",
	[247911] =  "Gisement de tellurium chargé",
	[179498] =  "Cantine écarlate",
	[184741] =  "Cantine abîmée",
	[182951] =  "Eau pure",
	[243564] =  "Panier d’herbes séchées",
	[247912] =  "Gisement de tellurium admirable",
	[218629] =  "Dipneuste de jade luminescent",
	[182952] =  "Détritus de la pompe à vapeur",
	[252772] =  "Morceau de mana ancestral",
	[247913] =  "Gisement de tellurium magnifique",
	[218630] =  "Grande réserve de dipneustes de jade luminescents",
	[182953] =  "Banc de poissons-spores",
	[210958] =  "Affleurement de chrysobéryl",
	[268466] =  "Trouvaille archéologique démoniaque",
	[186662] =  "Bourse de réactifs",
	[218631] =  "Colonie de poissons-spatules paniqués",
	[182954] =  "Banc mixte en eaux saumâtres",
	[252774] =  "Cristal de mana ancestral",
	[210959] =  "Affleurement de chrysobéryl",
	[247915] =  "Gisement de tellurium remarquable",
	[218632] =  "Grande colonie de poissons-spatules paniqués",
	[243312] =  "Riche gisement de rochenoire",
	[210960] =  "Affleurement de chrysobéryl",
	[247916] =  "Gisement de tellurium antique",
	[218633] =  "Saumon empereur affolé par la bière",
	[243313] =  "Gisement de rochenoire",
	[181166] =  "Chardon sanglant",
	[203800] =  "Tonneau de poissons des canaux",
	[247917] =  "Gisement de tellurium sombre",
	[180655] =  "Déchets flottants",
	[218634] =  "Grande réserve de saumons empereurs affolés par la bière",
	[243314] =  "Gisement de vérifer",
	[202778] =  "Banc de tétras cavernicoles albinos",
	[247918] =  "Gisement de tellurium orageux",
	[218635] =  "Boue de gouramis tigres",
	[182958] =  "Banc d'éperlans",
	[235387] =  "Ignescente",
	[202779] =  "Banc d'éperlans ventre-noir",
	[181680] =  "Champignon tête-sèche",
	[218636] =  "Grande réserve de boue de gouramis tigres",
	[182959] =  "Banc de tassergals",
	[235388] =  "Dionée de Gorgrond",
	[202780] =  "Banc d'anguilles des profondeurs",
	[180658] =  "Banc de poissons déviants",
	[194213] =  "Jacinthe d'hiver",
	[235389] =  "Bourrache",
	[175928] =  "Agave d'incendia",
	[235390] =  "Sagittaire de Nagrand",
	[260495] =  "Poudre de telluréclat",
	[181555] =  "Gisement de gangrefer",
	[273538] =  "Fournitures de guerre de la Légion",
	[214547] =  "[Shipwreck Debris]",
	[235135] =  "Artéfacts apogides de contrebande",
	[273533] =  "Fournitures de guerre de la Légion",
	[202655] =  "Trouvaille archéologique trolle",
	[2653] =  "Gisement de pierre de sang inférieure",
	[247923] =  "Gisement de gangreschiste noirci",
	[181556] =  "Gisement d’adamantite",
	[273527] =  "Fournitures de guerre de la Légion",
	[191019] =  "Langue de serpent",
	[271554] =  "Coffre langue-de-wyrm voilé",
	[272771] =  "Fournitures de guerre érédars",
	[272770] =  "Fournitures de guerre érédars",
	[228573] =  "Dionée de Gorgrond",
	[247924] =  "Gisement de gangreschiste embrasé",
	[181557] =  "Filon de khorium",
	[180662] =  "Débris de goélette",
	[271849] =  "Fournitures de guerre érédars",
	[277637] =  "Cache infiltrée par le Vide",
	[246518] =  "Coffre détrempé",
	[273443] =  "Cache infiltrée par le Vide",
	[271227] =  "Cache de langue-de-wyrm dissimulée",
	[247925] =  "Gisement de gangreschiste lourd",
	[252408] =  "Éclat de mana ancestral",
	[273439] =  "Ancienne cache érédar",
	[273414] =  "Ancienne cache érédar",
	[208540] =  "Magmolia",
	[273407] =  "Ancienne cache érédar",
	[273301] =  "Ancienne cache érédar",
	[192556] =  "Champignon de la caverne",
	[186648] =  "Malle d'Hazlek",
	[233715] =  "Butin d’Orpion",
	[218649] =  "Grande réserve de mandarins ventre-rouge agglutinés",
	[153468] =  "Grand coffre cerclé de mithril",
	[179496] =  "Cantine abîmée",
	[20691] =  "Cantine de Cozzle",
	[179491] =  "Cantine détrempée",
	[176189] =  "Squelette de tortue de mer",
	[179488] =  "Cantine endommagée",
	[205089] =  "Graine de pique-chardon",
	[255344] =  "Veine de gangreschiste",
	[192046] =  "Banc de rascasses dos-de-moule",
	[179486] =  "Cantine endommagée",
	[179487] =  "Cantine détrempée",
	[247607] =  "Fjarnskaggl florissant",
	[184845] =  "[Strange Pool]",
	[236756] =  "[Oily Abyssal Gulper School]",
	[218650] =  "Poisson-hérisson touché par les sha",
	[185557] =  "Ancien filon de gemmes",
	[252404] =  "Gangrèche",
	[243325] =  "Banc de gangregoulots frénétiques",
	[218651] =  "Grande réserve de poissons-hérissons touchés par les sha",
	[181271] =  "Glaurier",
	[248019] =  "Aethril vivace",
	[247958] =  "Noyau de destructeur de soufre",
	[218653] =  "Grande réserve de danios joyaux scintillants",
	[209311] =  "Gisement d’ectofer",
	[192048] =  "Banc de demoiselles aileron-de-dragon",
	[208544] =  "Magmolia",
	[247968] =  "Noyau de destructeur de soufre",
	[202736] =  "Gisement d’obsidium",
	[209952] =  "Jadelune",
	[228493] =  "Gisement de vérifer",
	[194100] =  "Patte d'ours",
	[209312] =  "Gisement de kyparite",
	[192049] =  "Banc de harengs crocs-pointus",
	[191303] =  "Epine de feu",
	[2042] =  "Pâlerette",
	[123309] =  "Gisement de vrai-argent couvert de vase",
	[186423] =  "Sorbier",
	[210080] =  "Tonneau de mûres",
	[210209] =  "Lotus impérial",
	[209313] =  "Filon de trillium",
	[192050] =  "Banc de saumons glaciaires",
	[180685] =  "Débris trempés",
	[321] =  "Larme de Tilloa",
	[209825] =  "Amanite de Raz-de-Brume",
	[202737] =  "Gisement de pyrite",
	[246811] =  "Trouvaille archéologique des Bien-nés",
	[192818] =  "Champignon infusé",
	[248025] =  "Songefeuille touffue",
	[192051] =  "Banc de poissons-méduses boréens",
	[180901] =  "Débris de la Voile sanglante",
	[202738] =  "Filon d’élémentium",
	[228991] =  "Givrebaie",
	[248026] =  "Songefeuille odorante",
	[209059] =  "Ortie de sang",
	[243315] =  "Riche gisement de vérifer",
	[202739] =  "Riche gisement d’obsidium",
	[192052] =  "Banc de raies manta impériales",
	[236169] =  "Précieux cristal récoltable",
	[324] =  "Petit filon de thorium",
	[206764] =  "Chapeneige émeraude",
	[205423] =  "Clochettes de banshee",
	[248028] =  "Fjarnskaggl épineux",
	[211721] =  "Cédrat pourpre",
	[202741] =  "Riche filon d’élémentium",
	[192053] =  "Banc de baudroies abyssales",
	[206503] =  "Chapelette",
	[248002] =  "Gangrèche",
	[188345] =  "Chapeneiges chatoyants",
	[182957] =  "Banc mixte des Hautes-terres",
	[234105] =  "Trouvaille archéologique arakkoa",
	[202776] =  "Banc de truites de montagne",
	[218648] =  "Mandarins ventre-rouge agglutinés",
	[192054] =  "Banc de seiches lueur-de-lune",
	[234106] =  "Trouvaille archéologique ogre",
	[248009] =  "Gangrèche",
	[185881] =  "Buisson de pruinéante",
	[191543] =  "Malle de l'Assaut écarlate",
	[247936] =  "Affleurement de tellurium grossier",
	[181569] =  "Riche gisement d’adamantite",
	[244774] =  "Aethril",
	[269278] =  "Herbe incrustée de corruption",
	[208551] =  "Lucifleur",
	[175566] =  "Herbe des ténèbres",
	[210538] =  "Fleur éternelle",
	[207189] =  "Trouvaille archéologique vrykule",
	[247937] =  "Affleurement de tellurium lumineux",
	[181570] =  "Riche gisement d’adamantite",
	[176583] =  "Sansam doré",
	[208878] =  "Champignon « magique »",
	[243334] =  "Herbe flétrie",
	[216764] =  "Banc de sagerelles",
	[202619] =  "Fleur-de-flammes",
	[202747] =  "Cendrelle",
	[247938] =  "Affleurement de tellurium scintillant",
	[218652] =  "Banc de danios joyaux scintillants",
	[176584] =  "Feuillerêve",
	[192057] =  "Banc de méduses",
	[226967] =  "Bassin du lagon",
	[123330] =  "Coffre du boucanier",
	[208816] =  "Champignon des égouts",
	[205367] =  "Aconit",
	[247939] =  "Affleurement de tellurium radieux",
	[209836] =  "Pétales fraîchement tombés",
	[210537] =  "Fleur éternelle",
	[216610] =  "Fer krasari",
	[1734] =  "Filon d’or",
	[176753] =  "Herbe maléfique",
	[212902] =  "Ambre solidifié",
	[229067] =  "Banc de furtifs agnathes",
	[247940] =  "Affleurement de tellurium durci",
	[248010] =  "Gangrèche",
	[176586] =  "Sauge-argent des montagnes",
	[192059] =  "Banc de vairons nageverres",
	[182956] =  "Banc de dards",
	[202754] =  "Baies de genévrier",
	[247914] =  "Gisement de tellurium supérieur",
	[237396] =  "Ignescente",
	[247941] =  "Affleurement de tellurium dense",
	[192827] =  "Moutarde sauvage",
	[176587] =  "Chagrinelle",
	[272778] =  "Riche gisement d'empyrium",
	[189981] =  "Riche gisement de saronite",
	[1617] =  "Feuillargent",
	[228563] =  "Gisement de rochenoire",
	[272782] =  "Astralée",
	[247942] =  "Affleurement de tellurium primaire",
	[192828] =  "Carotte du Chant de cristal",
	[176588] =  "Chapeglace",
	[1621] =  "Eglantine",
	[1622] =  "Doulourante",
	[228564] =  "Riche gisement de rochenoire",
	[190399] =  "Champignon chapebrouille",
	[201737] =  "Fleur en bourgeon",
	[247943] =  "Affleurement de gangreschiste malveillant",
	[182599] =  "Palme telaari",
	[176589] =  "Lotus noir",
	[226521] =  "Trouvaille archéologique des clans de Draenor",
	[201738] =  "Fleur en bourgeon",
	[271850] =  "Fournitures de guerre érédars",
	[221541] =  "Filon de trillium",
	[205099] =  "Sinistrine féroce",
	[268450] =  "Trouvaille archéologique taurène de Haut-Roc",
	[182600] =  "Canneberge",
	[180682] =  "Banc de bouches-noires huileux",
	[234449] =  "Reliques des parias",
	[202421] =  "Epine de Xavren",
	[245324] =  "Riche gisement de tellurium",
	[228574] =  "Bourrache",
	[214510] =  "Plante touchée par les sha",
	[228575] =  "Sagittaire de Nagrand",
	[182601] =  "Racine d'olemba",
	[180683] =  "Banc de lutjans de nagefeu",
	[216227] =  "Racine cassante",
	[202422] =  "Tige de myéloflée",
	[248008] =  "Gangrèche",
	[187333] =  "Buisson de sangrelle",
	[235391] =  "Orchidée de Talador",
	[235095] =  "Parchemin égaré",
	[191133] =  "Veine de titane",
	[209328] =  "Riche gisement d’ectofer",
	[206387] =  "Seau d'eau",
	[202777] =  "Banc de guppys des Hautes-terres",
	[181068] =  "Petit morceau d'obsidienne",
	[181894] =  "Collybie gangrenée",
	[230428] =  "Gisement fumant de vérifer",
	[228510] =  "Riche gisement de vérifer",
	[180684] =  "Banc de grandes sagerelles",
	[209329] =  "Riche gisement de kyparite",
	[13874] =  "Fleur de serpent",
	[211474] =  "Loupiote",
	[247988] =  "Veine de tellurium brut",
}

