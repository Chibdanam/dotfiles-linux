--[[
============================================================================================
    OPTIONS NEOVIM STANDALONE
============================================================================================

  Ce fichier contient toutes les options pour Neovim en mode standalone (pas VSCode).
  Ces options configurent l'apparence, le comportement et l'ergonomie de l'éditeur.

  Pour chaque option, vous pouvez consulter l'aide détaillée avec :help 'nom_option'
  Exemple : :help 'number' pour en savoir plus sur les numéros de ligne

  NOTE: Les options sont organisées par catégories pour faciliter la navigation.
        Utilisez les marqueurs [[ Section \]\] pour sauter rapidement entre les sections.
--]]

-- [[ Leader Key ]]
--  IMPORTANT: La leader key doit être définie AVANT de charger les plugins !
--  La leader key sert de préfixe pour les raccourcis clavier personnalisés.
--
--  Map la leader key avec la touche espace
--  Permet de faire des raccourcis clavier custom sans pour autant défaire les raccourcis existant
--  juste en forçant un prefix avec la leaderkey
--  (à tout moment il y a des side effects à ça, à voir)
--
--  Exemples d'utilisation :
--    <leader>ff - Recherche de fichiers (avec Telescope)
--    <leader>gd - Aller à la définition (avec LSP)
--
--  TIP: Espace est un excellent choix car il est facile à atteindre et rarement utilisé en mode normal
--  Voir :help mapleader
vim.g.mapleader = " "

-- [[ Apparence - Numérotation des Lignes ]]
--  Les numéros de ligne aident à naviguer et à référencer le code.
--
--  Affiche les nombres + relatif
--  - number : affiche le numéro absolu de la ligne courante
--  - relativenumber : affiche les numéros relatifs pour les autres lignes
--
--  NOTE: Les numéros relatifs facilitent les déplacements verticaux avec des commandes comme 5j ou 3k
--  Voir :help 'number' et :help 'relativenumber'
vim.opt.number = true
vim.opt.relativenumber = true

-- [[ Comportement des Fenêtres Splitées ]]
--  Configure où les nouvelles fenêtres apparaissent lors d'un split.
--
--  Modifie la position de la fenêtre splitée
--  - splitbelow : les splits horizontaux (:split) s'ouvrent en bas
--  - splitright : les splits verticaux (:vsplit) s'ouvrent à droite
--
--  NOTE: Le comportement par défaut (en haut/gauche) est contre-intuitif pour la plupart des utilisateurs
--  Voir :help 'splitbelow' et :help 'splitright'
vim.opt.splitbelow = true
vim.opt.splitright = true

-- [[ Édition - Gestion des Tabulations ]]
--  Configure comment les touches Tab et les indentations sont gérées.
--
--  Convertit les tab en spaces
--  - expandtab : remplace les caractères Tab par des espaces
--  - tabstop : définit la largeur visuelle d'un caractère Tab (4 espaces)
--  - shiftwidth : définit le nombre d'espaces utilisés pour l'indentation automatique (avec >> ou <<)
--
--  NOTE: Utiliser des espaces au lieu de tabs évite les problèmes d'affichage entre différents éditeurs
--  TIP: Beaucoup de projets utilisent 2 espaces ; ajustez selon vos besoins
--  Voir :help 'expandtab', :help 'tabstop', :help 'shiftwidth'
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- [[ Édition - Comportement du Texte ]]
--  Options qui affectent l'affichage et l'édition du texte.
--
--  Désactive les word wrap
--  Empêche Neovim de couper automatiquement les lignes longues à la largeur de l'écran.
--  Les lignes longues nécessiteront un défilement horizontal.
--
--  TIP: Certains préfèrent wrap=true pour la lecture de texte, mais wrap=false pour le code
--  Voir :help 'wrap'
vim.opt.wrap = false

--  Permet de garder la ligne en cours centrée
--  scrolloff=999 garde toujours la ligne courante au centre de l'écran lors du défilement.
--
--  NOTE: Une valeur de 8-10 est plus commune (garde 8 lignes de contexte), 999 centre toujours
--  TIP: Essayez différentes valeurs pour trouver ce qui vous convient le mieux
--  Voir :help 'scrolloff'
vim.opt.scrolloff = 999

--  Permet de manipuler le VISUAL mode en forme de block avec ctrl-V
--  mais en vrai ça marche pas pour le moment :s
--
--  NOTE: virtualedit="block" permet de placer le curseur au-delà de la fin de ligne en mode Visual Block
--        C'est utile pour sélectionner des colonnes rectangulaires dans du texte irrégulier
--  TIP: Si cela ne fonctionne pas comme prévu, vérifiez que vous êtes bien en Visual Block mode (Ctrl-V)
--       et non en Visual mode normal (v) ou Visual Line mode (V)
--  Voir :help 'virtualedit' et :help visual-block
vim.opt.virtualedit = "block"

--  Permet d'afficher une preview pour genre les remplacements
--  Affiche un aperçu en temps réel des commandes de substitution (:%s/ancien/nouveau/)
--  dans une fenêtre split.
--
--  NOTE: Extrêmement utile pour visualiser les changements avant de les valider
--  TIP: Essayez :%s/foo/bar/g avec cette option activée pour voir la magie opérer
--  Voir :help 'inccommand'
vim.opt.inccommand = "split"

-- [[ Recherche ]]
--  Configure le comportement de la recherche avec / et ?.
--
--  Ignore la casse lors de la recherche
--  Rend les recherches insensibles à la casse (foo trouve foo, Foo, FOO, etc.)
--
--  NOTE: Si votre recherche contient une majuscule, la casse sera respectée (avec smartcase activé)
--  TIP: Combinez avec :set smartcase pour un comportement intelligent
--  TODO: Ajouter vim.opt.smartcase = true pour respecter la casse uniquement quand une majuscule est présente
--  Voir :help 'ignorecase' et :help 'smartcase'
vim.opt.ignorecase = true

-- [[ Intégration Système ]]
--  Options qui connectent Neovim au système d'exploitation.
--
--  Bind le clipboard de nvim à celui du système Linux
--  Permet de copier/coller entre Neovim et d'autres applications avec y (yank) et p (paste)
--
--  NOTE: Nécessite un clipboard provider (xclip ou xsel)
--  Voir :help 'clipboard' et :checkhealth pour vérifier votre clipboard provider
vim.opt.clipboard = "unnamedplus"

-- [[ Apparence - Couleurs ]]
--  Active le support des couleurs 24-bit (true colors) dans le terminal.
--
--  Permet d'activer les couleurs de manière plus cool
--  Nécessaire pour afficher correctement les thèmes modernes avec toutes leurs nuances.
--
--  NOTE: Votre terminal doit supporter les true colors (la plupart des terminaux modernes le font)
--  TIP: Si les couleurs semblent bizarres, vérifiez que votre terminal supporte les true colors
--  Voir :help 'termguicolors'
vim.opt.termguicolors = true

-- [[ TODO: Options Supplémentaires à Explorer ]]
--  Voici quelques options utiles que vous pourriez vouloir ajouter à l'avenir :
--
--  TODO: vim.opt.mouse = 'a'                    -- Active le support de la souris
--  TODO: vim.opt.undofile = true                -- Sauvegarde l'historique d'annulation entre les sessions
--  TODO: vim.opt.signcolumn = 'yes'             -- Toujours afficher la colonne des signes (évite le décalage)
--  TODO: vim.opt.updatetime = 250               -- Temps avant de sauvegarder le swap file (affecte CursorHold)
--  TODO: vim.opt.timeoutlen = 300               -- Temps d'attente pour les séquences de touches mappées
--  TODO: vim.opt.smartcase = true               -- Respecte la casse si la recherche contient une majuscule
--  TODO: vim.opt.cursorline = true              -- Surligne la ligne courante
--  TODO: vim.opt.list = true                    -- Affiche les caractères invisibles (tabs, espaces, etc.)
--  TODO: vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
--
--  Pour des autocommands utiles (highlight on yank, etc.), voir :help lua-guide-autocommands


