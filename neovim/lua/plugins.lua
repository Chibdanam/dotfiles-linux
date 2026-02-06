--[[
============================================================================================
    PLUGINS - POINT D'ENTRÉE POUR LAZY.NVIM
============================================================================================

  QU'EST-CE QUE CE FICHIER ?
  ---------------------------
  Ce fichier sert de point d'entrée pour lazy.nvim, le gestionnaire de plugins.
  Quand vous appelez require("lazy").setup("plugins") dans init.lua, lazy.nvim
  charge automatiquement ce fichier.

  POURQUOI EST-IL VIDE ?
  -----------------------
  Ce fichier retourne une table vide {} car nous utilisons la fonctionnalité de
  DÉCOUVERTE AUTOMATIQUE de lazy.nvim.

  Au lieu de lister tous les plugins ici dans un seul fichier massif, nous les
  organisons dans des fichiers séparés dans le dossier lua/plugins/ :

    lua/plugins/
    ├── lsp-config.lua      - Configuration LSP (Mason, LSPConfig)
    ├── roslyn.lua          - Serveur LSP C# moderne (Roslyn)
    ├── telescope.lua       - Recherche floue
    ├── treesitter.lua      - Analyse syntaxique
    ├── neotree.lua         - Explorateur de fichiers
    ├── copilot.lua         - Assistant IA
    └── colorscheme.lua     - Thème de couleurs

  COMMENT LAZY.NVIM DÉCOUVRE LES PLUGINS ?
  -----------------------------------------
  lazy.nvim scanne automatiquement tous les fichiers .lua dans lua/plugins/
  et charge les spécifications de plugins qu'ils retournent.

  Chaque fichier doit retourner :
    • Une table de plugin : return { 'author/plugin-name', config = ... }
    • Un tableau de plugins : return { {...}, {...} }

  AVANTAGES DE CETTE APPROCHE MODULAIRE :
    ✓ Organisation claire par fonctionnalité
    ✓ Facile de trouver et modifier la config d'un plugin spécifique
    ✓ Peut activer/désactiver un plugin en renommant le fichier (ex: .lua.bak)
    ✓ Évite un fichier plugins.lua gigantesque et difficile à maintenir
    ✓ Chargement plus rapide (lazy.nvim optimise automatiquement)

  ALTERNATIVE (APPROCHE MONOLITHIQUE) :
  -------------------------------------
  Vous POUVEZ mettre tous les plugins ici si vous préférez :

  return {
      { 'nvim-telescope/telescope.nvim', ... },
      { 'nvim-treesitter/nvim-treesitter', ... },
      { 'neovim/nvim-lspconfig', ... },
      -- ... tous les autres plugins ...
  }

  Mais l'approche modulaire (fichiers séparés) est recommandée pour les
  configurations de taille moyenne à grande.

  NOTE: Même si ce fichier est vide, il DOIT exister pour que lazy.nvim
        fonctionne correctement avec require("lazy").setup("plugins")

  Voir :help lazy.nvim pour plus de détails sur le système de plugins
--]]

-- [[ COMMENT AJOUTER UN NOUVEAU PLUGIN ? ]]
--
--  MÉTHODE 1 : Créer un nouveau fichier dans lua/plugins/ (RECOMMANDÉ)
--  --------------------------------------------------------------------
--  1. Créez un fichier : lua/plugins/mon-plugin.lua
--  2. Ajoutez votre configuration de plugin :
--
--     return {
--         'author/plugin-name',
--         config = function()
--             -- Configuration ici
--         end
--     }
--
--  3. Redémarrez Neovim : le plugin sera automatiquement découvert et installé !
--
--  MÉTHODE 2 : Ajouter dans ce fichier (pour des plugins simples)
--  ---------------------------------------------------------------
--  Décommentez et remplacez return {} ci-dessous par :
--
--  return {
--      { 'author/plugin-name', config = function() ... end },
--  }
--
--  EXEMPLES DE PLUGINS UTILES À EXPLORER :
--    • 'windwp/nvim-autopairs'          - Ferme automatiquement les parenthèses/guillemets
--    • 'numToStr/Comment.nvim'          - Commenter/décommenter facilement (gcc, gbc)
--    • 'lewis6991/gitsigns.nvim'        - Affiche les changements git dans la marge
--    • 'lukas-reineke/indent-blankline.nvim' - Guides d'indentation visuels
--    • 'folke/which-key.nvim'           - Affiche les raccourcis clavier disponibles
--    • 'nvim-lualine/lualine.nvim'      - Statusline moderne et configurable
--    • 'akinsho/toggleterm.nvim'        - Terminal intégré avec toggle
--
--  TIP: Cherchez des configurations complètes sur GitHub pour voir comment
--       d'autres utilisateurs organisent leurs plugins !

return {}