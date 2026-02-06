--[[
============================================================================================
    NEO-TREE - EXPLORATEUR DE FICHIERS
============================================================================================

  QU'EST-CE QUE NEO-TREE ?
  -------------------------
  Neo-tree est un explorateur de fichiers moderne pour Neovim, similaire à la sidebar
  dans VSCode, Sublime Text, ou IntelliJ. Il affiche l'arborescence de votre projet
  dans un panneau latéral.

  FONCTIONNALITÉS PRINCIPALES :
    • Navigation visuelle dans l'arborescence des fichiers
    • Icônes pour les types de fichiers (grâce à nvim-web-devicons)
    • Support Git (affiche les fichiers modifiés, ajoutés, ignorés)
    • Buffers explorer (liste des fichiers ouverts)
    • Opérations sur les fichiers (créer, renommer, supprimer, copier)
    • Recherche de fichiers dans l'arbre
    • Filtrage et tri personnalisables

  COMMANDES DANS NEO-TREE :
    Navigation :
      <Enter>    - Ouvrir le fichier ou dossier
      h / l      - Fermer / Ouvrir un dossier
      <Space>    - Prévisualiser le fichier sans ouvrir

    Actions sur les fichiers :
      a          - Ajouter un nouveau fichier/dossier (terminer par / pour un dossier)
      d          - Supprimer
      r          - Renommer
      c / x / p  - Copier / Couper / Coller
      y          - Copier le chemin du fichier dans le clipboard

    Affichage :
      H          - Toggle les fichiers cachés (dotfiles)
      R          - Rafraîchir l'arbre
      ?          - Afficher l'aide complète des raccourcis
      q / <Esc>  - Fermer Neo-tree

  NOTE: Neo-tree reste ouvert jusqu'à ce que vous le fermiez manuellement (toggle avec <leader>n)

  Voir :help neo-tree pour la documentation complète
--]]

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x', -- Utilise la dernière version stable de la branche 3.x

    -- [[ Dépendances Requises ]]
    --  Neo-tree nécessite plusieurs plugins pour fonctionner :
    dependencies = {
        -- plenary.nvim : Bibliothèque de fonctions utilitaires Lua (utilisée par beaucoup de plugins)
        'nvim-lua/plenary.nvim',

        -- nvim-web-devicons : Fournit les icônes pour chaque type de fichier
        --   (icônes pour .js, .py, .lua, .md, dossiers, etc.)
        --   NOTE: Nécessite une Nerd Font installée dans votre terminal !
        --   Téléchargez une Nerd Font : https://www.nerdfonts.com/
        'nvim-tree/nvim-web-devicons',

        -- nui.nvim : Framework UI pour créer des interfaces utilisateur dans Neovim
        --   (utilisé pour les popups, inputs, menus de Neo-tree)
        'MunifTanjim/nui.nvim',
    },

    config = function()
        -- [[ Keybinding Neo-tree ]]
        --  <leader>n : Toggle (ouvrir/fermer) l'explorateur de fichiers
        --
        --  EXPLICATION DE LA COMMANDE :
        --    :Neotree           - Commande principale de Neo-tree
        --    filesystem         - Mode filesystem (autres modes : buffers, git_status)
        --    reveal             - Révèle le fichier actuellement ouvert dans l'arbre
        --    left               - Positionne Neo-tree à gauche de l'écran
        --
        --  ALTERNATIVES :
        --    reveal right     - Affiche à droite
        --    reveal float     - Affiche dans une fenêtre flottante
        --    reveal current   - Affiche dans le buffer actuel
        --
        --  TIP: Utilisez <leader>n pour ouvrir, puis naviguez avec j/k, Enter pour ouvrir les fichiers
        vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>', {
            desc = "Toggle Neo-tree"
        })

        -- TODO: Configuration avancée de Neo-tree
        --   Décommentez et personnalisez selon vos besoins :
        --
        -- require('neo-tree').setup({
        --     close_if_last_window = true,  -- Ferme Neo-tree si c'est la dernière fenêtre
        --     window = {
        --         width = 30,                -- Largeur de la fenêtre Neo-tree
        --         position = "left",         -- Position : "left", "right", "float"
        --     },
        --     filesystem = {
        --         follow_current_file = {
        --             enabled = true,        -- Suit le fichier actuel dans l'arbre
        --         },
        --         filtered_items = {
        --             hide_dotfiles = false, -- Afficher les fichiers cachés (.gitignore, etc.)
        --             hide_by_name = {
        --                 "node_modules",    -- Masquer certains dossiers
        --             },
        --         },
        --     },
        -- })
    end
}

-- [[ TODO: Fonctionnalités Supplémentaires à Explorer ]]
--
--  AUTRES MODES DE NEO-TREE :
--    :Neotree buffers       - Liste tous les buffers ouverts
--    :Neotree git_status    - Affiche le statut git (fichiers modifiés, ajoutés, etc.)
--    :Neotree close         - Ferme Neo-tree
--
--  INTÉGRATION GIT :
--    Neo-tree affiche automatiquement l'état git des fichiers avec des icônes/couleurs :
--      • Vert  : Fichiers ajoutés (staged)
--      • Bleu  : Fichiers modifiés
--      • Rouge : Fichiers supprimés
--      • Gris  : Fichiers ignorés (.gitignore)
--
--  ALTERNATIVES À NEO-TREE :
--    Si Neo-tree ne vous convient pas, vous pouvez essayer :
--      • nvim-tree.lua    - Plus léger et simple
--      • oil.nvim         - Édite les dossiers comme des buffers (approche unique)
--      • dirbuf.nvim      - Utilise les buffers natifs de Neovim
--
--  NOTE: Vous pouvez aussi utiliser :Ex (commande native Neovim) pour un explorateur basique
--
--  Voir :help neo-tree-commands pour toutes les commandes disponibles
