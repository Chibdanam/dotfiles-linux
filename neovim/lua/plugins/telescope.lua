--[[
============================================================================================
    TELESCOPE - RECHERCHE FLOUE (FUZZY FINDER)
============================================================================================

  QU'EST-CE QUE TELESCOPE ?
  --------------------------
  Telescope est un outil de recherche floue (fuzzy finder) hautement extensible et configurable.
  C'est l'un des plugins les plus populaires de Neovim car il permet de trouver rapidement
  n'importe quoi dans votre projet.

  FONCTIONNALITÉS PRINCIPALES :
    • Recherche de fichiers par nom (même avec des fautes de frappe)
    • Recherche de texte dans tous les fichiers (live grep)
    • Navigation entre les buffers ouverts
    • Recherche dans l'aide Neovim
    • Recherche de symboles LSP (fonctions, variables, etc.)
    • Historique des commandes et de recherche
    • Liste des keybindings disponibles
    • Et bien plus...

  COMMENT UTILISER TELESCOPE ?
  -----------------------------
  Après avoir ouvert un picker Telescope :
    • Tapez pour filtrer les résultats (fuzzy matching intelligent)
    • <C-n> / <C-p>  : Naviguer vers le bas/haut
    • <Enter>        : Sélectionner l'élément
    • <C-x>          : Ouvrir dans un split horizontal
    • <C-v>          : Ouvrir dans un split vertical
    • <C-t>          : Ouvrir dans un nouvel onglet
    • <Esc>          : Fermer Telescope

  NOTE: Telescope utilise ripgrep (rg) pour live_grep. Assurez-vous qu'il est installé !
        Sur Linux : sudo apt install ripgrep (ou via mise)

  Voir :help telescope.nvim pour la documentation complète
--]]

return {
    -- [[ Plugin Principal : Telescope ]]
    --  Le cœur du système de recherche floue.
    --
    --  branch = '0.1.x' : Utilise la dernière version stable de la branche 0.1
    --  dependencies : plenary.nvim fournit des fonctions utilitaires Lua nécessaires à Telescope
    --
    --  Voir :help telescope.builtin pour la liste complète des pickers disponibles
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')

            -- [[ Keybindings Telescope ]]
            --  NOTE: Tous les raccourcis commencent par <leader>f (f pour "find")
            --  TIP: Utilisez :Telescope keymaps pour voir tous vos raccourcis clavier

            -- Recherche de fichiers par nom dans le projet
            -- Ignore les fichiers dans .gitignore par défaut
            -- Exemple : Taper "init" trouve "init.lua", "init-config.lua", etc.
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {
                desc = "Rechercher des fichiers"
            })

            -- Recherche de texte dans tous les fichiers (live grep)
            -- Utilise ripgrep pour une recherche ultra-rapide
            -- Tape une chaîne et vois les résultats en temps réel dans tous les fichiers
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {
                desc = "Rechercher du texte (grep)"
            })

            -- Liste tous les buffers (fichiers) ouverts
            -- Permet de switcher rapidement entre les fichiers ouverts
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {
                desc = "Rechercher dans les buffers"
            })

            -- Recherche dans toute la documentation d'aide de Neovim
            -- Essayez de chercher "telescope" ou "lsp" pour voir la magie !
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {
                desc = "Rechercher dans l'aide"
            })

            -- TODO: Autres pickers utiles à considérer :
            --   vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Fichiers récents" })
            --   vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = "Chercher le mot sous le curseur" })
            --   vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "Liste des commandes" })
            --   vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Liste des keybindings" })
            --   vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Symboles LSP du document" })
        end
    },

    -- [[ Extension : Telescope UI Select ]]
    --  Cette extension remplace les menus de sélection natifs de Neovim (vim.ui.select)
    --  par l'interface Telescope, ce qui rend toutes les sélections plus belles et cohérentes.
    --
    --  EXEMPLES D'UTILISATION :
    --    • LSP code actions (<leader>ca) : affiche les actions dans une belle liste Telescope
    --    • Sélection de colorscheme
    --    • N'importe quelle sélection dans des plugins
    --
    --  get_dropdown : Style d'affichage (menu dropdown au centre de l'écran)
    --  Autres styles disponibles : get_ivy (en bas), get_cursor (sous le curseur)
    --
    --  Voir :help telescope-ui-select.nvim
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- Vous pouvez personnaliser le thème ici si besoin
                        }
                    }
                }
            }
            -- Charger l'extension après la configuration
            require("telescope").load_extension("ui-select")
        end
    }
}

-- [[ TODO: Améliorations Telescope ]]
--
--  EXTENSIONS POPULAIRES :
--    • telescope-fzf-native.nvim  - Améliore les performances de recherche avec fzf (C)
--    • telescope-file-browser.nvim - Explorateur de fichiers dans Telescope
--    • telescope-project.nvim     - Gestion de projets
--
--  PERSONNALISATION :
--    • Changer les thèmes (dropdown, ivy, cursor)
--    • Configurer les options de layout (largeur, hauteur)
--    • Ajouter des prévisualisations personnalisées
--    • Créer vos propres pickers
--
--  NOTE: Consultez :help telescope.setup pour voir toutes les options de configuration
