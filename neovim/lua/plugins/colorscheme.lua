--[[
============================================================================================
    COLORSCHEME - THÈME DE COULEURS KANAGAWA
============================================================================================

  QU'EST-CE QU'UN COLORSCHEME ?
  ------------------------------
  Un colorscheme (thème de couleurs) définit l'apparence visuelle de Neovim :
  couleurs du texte, de l'arrière-plan, des commentaires, des mots-clés, etc.

  Un bon colorscheme :
    • Réduit la fatigue oculaire
    • Améliore la lisibilité du code
    • Met en évidence la syntaxe de manière intuitive
    • S'adapte aux conditions d'éclairage (jour/nuit)

  POURQUOI KANAGAWA ?
  -------------------
  Kanagawa est un thème inspiré par les célèbres estampes japonaises
  "La Grande Vague de Kanagawa" de Hokusai. Il offre :
    • Des couleurs douces et harmonieuses
    • Un excellent contraste sans être agressif
    • Support complet de Treesitter et LSP
    • Trois variantes pour différentes ambiances

  VARIANTES DISPONIBLES :
    • kanagawa-wave   : Variante par défaut, équilibrée (fond moyen)
    • kanagawa-dragon : Plus sombre, idéal pour la nuit
    • kanagawa-lotus  : Plus clair, idéal pour le jour

  NOTE: Le thème nécessite termguicolors = true (déjà configuré dans options.lua)
        et fonctionne mieux avec une Nerd Font pour les icônes.

  Voir :help kanagawa.nvim pour la documentation complète
--]]

return {
    "rebelot/kanagawa.nvim",
    config = function()
        -- [[ Application du Thème Kanagawa ]]
        --  Applique la variante "wave" du thème Kanagawa.
        --
        --  POUR CHANGER DE VARIANTE :
        --    kanagawa-wave   : Équilibré (défaut)
        --    kanagawa-dragon : Sombre
        --    kanagawa-lotus  : Clair
        --
        --  TIP: Essayez les différentes variantes pour trouver celle qui vous convient !
        --       Changez "kanagawa-wave" ci-dessous et exécutez :source % pour recharger
        vim.cmd.colorscheme("kanagawa-wave")

        -- TODO: Configuration personnalisée de Kanagawa
        --   Vous pouvez personnaliser Kanagawa avant de l'appliquer :
        --
        -- require('kanagawa').setup({
        --     compile = false,  -- Active la compilation pour de meilleures performances
        --     undercurl = true, -- Active les soulignements ondulés pour les diagnostics
        --     commentStyle = { italic = true },
        --     functionStyle = {},
        --     keywordStyle = { italic = true },
        --     statementStyle = { bold = true },
        --     typeStyle = {},
        --     transparent = false,  -- Si true, rend l'arrière-plan transparent
        --     dimInactive = false,  -- Si true, assombrit les fenêtres inactives
        --     terminalColors = true,
        --     colors = {
        --         -- Vous pouvez personnaliser les couleurs ici
        --         palette = {},
        --         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        --     },
        --     overrides = function(colors)
        --         -- Personnaliser des groupes de highlight spécifiques
        --         return {}
        --     end,
        --     theme = "wave",  -- "wave", "dragon", "lotus" ou "all"
        -- })
        --
        -- vim.cmd.colorscheme("kanagawa")
    end,
}

-- [[ TODO: Explorer d'Autres Colorschemes ]]
--
--  Si Kanagawa ne vous convient pas, voici d'autres thèmes populaires :
--
--  THÈMES SOMBRES :
--    • catppuccin/nvim (Catppuccin) : Pastel doux avec plusieurs variantes
--    • folke/tokyonight.nvim        : Inspiré de Tokyo la nuit, très populaire
--    • navarasu/onedark.nvim        : Basé sur le thème Atom One Dark
--    • EdenEast/nightfox.nvim       : Famille de thèmes avec plusieurs variantes
--    • sainnhe/gruvbox-material     : Version moderne du classique Gruvbox
--
--  THÈMES CLAIRS :
--    • sainnhe/everforest           : Thème vert doux pour les yeux
--    • rose-pine/neovim (Rosé Pine) : Élégant et minimaliste
--
--  THÈMES CLASSIQUES :
--    • morhetz/gruvbox              : Le classique intemporel
--    • dracula/vim                  : Thème Dracula officiel
--
--  COMMENT CHANGER DE THÈME :
--    1. Ajoutez le plugin du thème dans cette fichier ou un nouveau fichier plugins/
--    2. Remplacez vim.cmd.colorscheme("kanagawa-wave") par le nom du nouveau thème
--    3. Redémarrez Neovim ou exécutez :source % puis :Lazy sync
--
--  TESTER UN THÈME TEMPORAIREMENT :
--    :colorscheme <nom>  - Change le thème pour la session actuelle
--    :Telescope colorscheme - Prévisualise tous les thèmes installés (si Telescope installé)
--
--  NOTE: La plupart des thèmes modernes supportent Treesitter et LSP pour
--        une coloration syntaxique optimale.
--
--  Voir :help colorscheme pour plus d'informations sur les thèmes dans Neovim
