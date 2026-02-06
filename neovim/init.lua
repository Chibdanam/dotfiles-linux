--[[
============================================================================================
    CONFIGURATION NEOVIM PERSONNELLE
============================================================================================

  Configuration complète avec gestion des plugins.
  Voir lua/options.lua pour les options Neovim.
--]]

-- Charger d'abord les options de base avant les plugins
require("options")

-- [[ Installation du Gestionnaire de Plugins lazy.nvim ]]
--  lazy.nvim est un gestionnaire de plugins moderne pour Neovim qui offre :
--    - Chargement paresseux automatique des plugins (améliore le temps de démarrage)
--    - Interface utilisateur élégante pour gérer les plugins
--    - Verrouillage des versions avec lazy-lock.json
--    - Gestion automatique des dépendances
--
--  NOTE: lazy.nvim s'installe automatiquement s'il n'est pas présent.
--        Au premier lancement, les plugins seront téléchargés automatiquement.
--
--  Pour gérer vos plugins après l'installation :
--    :Lazy          - Ouvrir l'interface de gestion
--    :Lazy update   - Mettre à jour tous les plugins
--    :Lazy sync     - Installer les plugins manquants et mettre à jour les existants
--    :Lazy clean    - Supprimer les plugins non utilisés
--
--  Voir :help lazy.nvim pour plus d'informations

-- Chemin où lazy.nvim sera installé
-- stdpath("data") pointe vers le dossier de données de Neovim (~/.local/share/nvim sur Linux)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Vérifier si lazy.nvim est déjà installé
if not vim.loop.fs_stat(lazypath) then
    -- Si lazy.nvim n'existe pas, le cloner depuis GitHub
    print("Installation de lazy.nvim...")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none", -- Clone partiel pour économiser de la bande passante
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- Utiliser la dernière version stable (recommandé pour éviter les bugs)
        lazypath
    })
    print("lazy.nvim installé ! Les plugins vont maintenant être téléchargés...")
end

-- Ajouter lazy.nvim au 'runtimepath' pour que Neovim puisse le trouver
-- runtimepath (rtp) est la liste des chemins où Neovim cherche les plugins et scripts
-- Voir :help runtimepath pour plus de détails
vim.opt.rtp:prepend(lazypath)

-- [[ Initialisation des Plugins ]]
--  Cette ligne charge tous les plugins définis dans le dossier lua/plugins/
--  lazy.nvim découvre automatiquement tous les fichiers .lua dans ce dossier
--  et charge les spécifications de plugins qu'ils retournent.
--
--  Chaque fichier dans lua/plugins/ doit retourner une table de configuration
--  ou un tableau de tables pour plusieurs plugins.
--
--  Exemple de structure :
--    lua/plugins/
--    ├── lsp-config.lua      - Configuration LSP
--    ├── roslyn.lua          - Serveur LSP C# (Roslyn)
--    ├── telescope.lua       - Recherche fuzzy
--    ├── treesitter.lua      - Coloration syntaxique
--    └── ...
--
--  NOTE: Le fichier lua/plugins.lua existe mais peut rester vide grâce
--        au système de découverte automatique de lazy.nvim.
require("lazy").setup("plugins")

-- TODO: Après avoir configuré Neovim, exécutez :Tutor pour un tutoriel interactif
-- TODO: Consultez :help lua-guide pour apprendre à personnaliser votre configuration

print("Loaded")
