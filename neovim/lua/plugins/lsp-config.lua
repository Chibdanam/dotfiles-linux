--[[
============================================================================================
    CONFIGURATION LSP (LANGUAGE SERVER PROTOCOL)
============================================================================================

  QU'EST-CE QUE LE LSP ?
  ----------------------
  Le Language Server Protocol (LSP) est un protocole standardisé qui permet à Neovim
  de communiquer avec des serveurs de langage pour obtenir des fonctionnalités
  d'IDE modernes :

    • Autocomplétion intelligente basée sur le contexte
    • Aller à la définition / références d'une fonction ou variable
    • Diagnostic en temps réel (erreurs, warnings)
    • Refactoring et actions de code (renommer, extraire, etc.)
    • Documentation au survol (hover)
    • Signatures de fonctions
    • Formatage automatique du code

  COMMENT ÇA FONCTIONNE ?
  -----------------------
  Neovim (client) <--LSP Protocol--> Language Server (lua_ls, rust-analyzer, etc.)

  Chaque langage a son propre serveur LSP qui comprend la syntaxe et la sémantique
  de ce langage. Par exemple :
    - lua_ls        : pour Lua
    - csharp_ls     : pour C# (léger et rapide)
    - roslyn        : pour C# (moderne, basé sur le compilateur Roslyn de Microsoft)
    - pyright       : pour Python
    - tsserver      : pour JavaScript/TypeScript
    - rust-analyzer : pour Rust

  NOTE: Pour C#, nous utilisons roslyn.nvim (fichier séparé) au lieu d'OmniSharp car
        OmniSharp n'est plus maintenu. Roslyn est le serveur utilisé par VSCode.

  ARCHITECTURE DE CETTE CONFIGURATION :
  -------------------------------------
  Nous utilisons 3 plugins qui travaillent ensemble :

  1. mason.nvim
     → Gestionnaire de paquets pour installer/mettre à jour les serveurs LSP
     → Interface graphique facile avec :Mason

  2. mason-lspconfig.nvim
     → Pont entre Mason et nvim-lspconfig
     → Installe automatiquement les serveurs listés dans ensure_installed

  3. nvim-lspconfig
     → Configure la communication entre Neovim et les serveurs LSP
     → Définit les keybindings pour interagir avec le LSP

  NOTE: Les serveurs LSP sont installés automatiquement au premier lancement !
        Vous verrez une fenêtre Mason s'ouvrir et télécharger les serveurs.

  NEOVIM 0.11+ : Nouvelle API LSP
  --------------------------------
  Cette configuration utilise la nouvelle API vim.lsp.enable() introduite dans
  Neovim 0.11. C'est plus simple et plus performant que l'ancienne méthode
  require('lspconfig').setup().

  Pour une configuration avancée d'un serveur, utilisez vim.lsp.config() :
    vim.lsp.config('servername', {
      cmd = { 'chemin/vers/serveur' },
      filetypes = { 'lua' },
      -- autres options...
    })

  Voir :help lsp et :help vim.lsp.enable() pour une documentation complète
--]]

return {
    -- [[ Plugin 1 : Mason - Gestionnaire d'Installation des Serveurs LSP ]]
    --  Mason est un gestionnaire de paquets qui facilite l'installation et la mise à jour
    --  des serveurs LSP, linters, formatters, et debuggers.
    --
    --  COMMANDES UTILES :
    --    :Mason          - Ouvre l'interface graphique de gestion
    --    :MasonInstall <nom>  - Installe un serveur manuellement
    --    :MasonUpdate    - Met à jour tous les paquets installés
    --
    --  NOTE: lazy=false force le chargement immédiat au démarrage (nécessaire pour LSP)
    --  Voir :help mason.nvim
    {
        'williamboman/mason.nvim',
        lazy = false, -- Charger immédiatement (ne pas lazy-load)
        config = function()
            -- NOTE: Le registre Crashdummyy est nécessaire pour installer Roslyn (serveur C#)
            require('mason').setup({
                registries = {
                    "github:mason-org/mason-registry",      -- Registre officiel
                    "github:Crashdummyy/mason-registry",    -- Registre pour Roslyn
                }
            })
        end
    },

    -- [[ Plugin 2 : Mason-LSPConfig - Pont entre Mason et LSPConfig ]]
    --  Ce plugin fait le lien entre Mason (qui installe les serveurs) et
    --  nvim-lspconfig (qui les configure).
    --
    --  ensure_installed : Liste des serveurs à installer automatiquement
    --
    --  SERVEURS ACTUELLEMENT INSTALLÉS :
    --    • lua_ls     - Serveur LSP pour Lua (utile pour configurer Neovim)
    --    • html       - Serveur LSP pour HTML
    --
    --  NOTE: Roslyn (pour C#) n'est PAS dans cette liste car il est géré par roslyn.nvim
    --        (voir lua/plugins/roslyn.lua). Roslyn inclut aussi le support Razor via cohosting.
    --
    --  NOTE: csharp_ls n'est plus utilisé car il entre en conflit avec Roslyn.
    --
    --  NOTE: Si vous ajoutez un serveur ici, redémarrez Neovim pour qu'il soit installé
    --  Voir :help mason-lspconfig.nvim
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'html' }
            })
        end
    },

    -- [[ Plugin 3 : LSPConfig - Configuration des Serveurs LSP ]]
    --  nvim-lspconfig fournit des configurations prêtes à l'emploi pour activer
    --  les serveurs LSP avec Neovim.
    --
    --  NOUVELLE API NEOVIM 0.11+ :
    --  À partir de Neovim 0.11, l'API LSP a été modernisée.
    --  On utilise maintenant vim.lsp.enable() au lieu de require('lspconfig').setup()
    --
    --  NOTE: lazy=false force le chargement au démarrage (important pour le LSP)
    --  Voir :help lspconfig et :help vim.lsp.enable()
    {
        "neovim/nvim-lspconfig",
        lazy = false, -- Charger immédiatement (ne pas lazy-load)
        config = function()
            -- [[ Activation des Serveurs LSP ]]
            --  Avec Neovim 0.11+, on utilise vim.lsp.enable() pour activer un serveur.
            --  Cette nouvelle API est plus simple et plus performante.
            --
            --  NOTE: Les configurations par défaut sont fournies par nvim-lspconfig
            --        et s'appliquent automatiquement lors de l'activation.

            -- Active lua_ls pour les fichiers .lua (configuration de Neovim)
            vim.lsp.enable('lua_ls')

            -- Active html pour les fichiers .html
            vim.lsp.enable('html')

            -- NOTE: Roslyn (C# + Razor via cohosting) est configuré dans lua/plugins/roslyn.lua

            -- [[ Keybindings LSP ]]
            --  Ces raccourcis clavier permettent d'interagir avec le serveur LSP actif.
            --  Ils ne fonctionnent que dans les fichiers où un serveur LSP est attaché.
            --
            --  TIP: Ouvrez un fichier .lua ou .cs et essayez ces commandes !
            --
            --  NOTE: Le mode 'n' signifie Normal mode (les commandes ne fonctionnent qu'en mode normal)
            --  Voir :help vim.lsp.buf pour toutes les fonctions LSP disponibles

            -- Affiche la documentation (hover) de la fonction/variable sous le curseur
            -- Par défaut, K en mode normal affiche le manuel. Ici on le remappe pour le LSP hover.
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {
                desc = "Afficher la documentation (LSP hover)"
            })

            -- Aller à la définition de la fonction/variable sous le curseur
            -- Ouvre le fichier où la fonction est définie et place le curseur dessus
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {
                desc = "Aller à la définition"
            })

            -- Trouver toutes les références (utilisations) de la fonction/variable
            -- Affiche une liste de tous les endroits où ce symbole est utilisé
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {
                desc = "Trouver les références"
            })

            -- Affiche les actions de code disponibles (quick fixes, refactoring, etc.)
            -- Par exemple : renommer une variable, importer un namespace manquant, etc.
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
                desc = "Actions de code"
            })

            -- TODO: Ajouter d'autres keybindings LSP utiles :
            --   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Renommer le symbole" })
            --   vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = "Formater le fichier" })
            --   vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostic précédent" })
            --   vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostic suivant" })
        end
    }
}

-- [[ TODO: Serveurs LSP Supplémentaires à Considérer ]]
--
--  Pour ajouter le support d'un nouveau langage, suivez ces étapes :
--    1. Ajoutez le nom du serveur à ensure_installed dans mason-lspconfig (ligne ~104)
--    2. Ajoutez un appel vim.lsp.enable('<serveur>') dans la config nvim-lspconfig (ligne ~131)
--    3. Redémarrez Neovim (ou :source %) pour installer et activer le serveur
--
--  EXEMPLE :
--    Pour ajouter Python avec pyright :
--      1. Dans mason-lspconfig : ensure_installed = { 'lua_ls', 'csharp_ls', 'pyright' }
--      2. Dans nvim-lspconfig : vim.lsp.enable('pyright')
--      3. Redémarrez Neovim
--
--  SERVEURS POPULAIRES :
--    • pyright ou pylsp     - Python
--    • tsserver             - TypeScript/JavaScript
--    • rust_analyzer        - Rust
--    • clangd               - C/C++
--    • gopls                - Go
--    • html, cssls          - HTML/CSS
--    • jsonls               - JSON
--
--  NOTE: Consultez la liste complète sur https://github.com/williamboman/mason-lspconfig.nvim
--        ou exécutez :Mason et parcourez les serveurs disponibles
--
--  CONFIGURATION AVANCÉE D'UN SERVEUR :
--    Si vous avez besoin de personnaliser un serveur LSP (cmd, filetypes, settings, etc.),
--    utilisez vim.lsp.config() AVANT vim.lsp.enable() :
--
--    vim.lsp.config('lua_ls', {
--      settings = {
--        Lua = {
--          diagnostics = {
--            globals = { 'vim' }  -- Reconnaît 'vim' comme global
--          }
--        }
--      }
--    })
--    vim.lsp.enable('lua_ls')
--
--  Pour plus d'informations :
--    :help vim.lsp.config()
--    :help vim.lsp.enable()
--    :help lspconfig-all
--    :help lspconfig-server-configurations
