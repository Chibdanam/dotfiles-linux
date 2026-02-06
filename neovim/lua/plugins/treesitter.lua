--[[
============================================================================================
    TREESITTER - ANALYSE SYNTAXIQUE ET COLORATION AVANCÉE
============================================================================================

  QU'EST-CE QUE TREESITTER ?
  ---------------------------
  Treesitter est un parseur (analyseur syntaxique) qui comprend la STRUCTURE du code,
  pas seulement les mots-clés. Il construit un arbre syntaxique abstrait (AST) du code
  en temps réel, ce qui permet :

    • Coloration syntaxique précise et contextuelle (mieux que regex)
    • Sélection incrémentale intelligente (sélectionner des blocs de code logiques)
    • Indentation automatique basée sur la structure du code
    • Navigation dans le code par nœuds syntaxiques
    • Pliage de code (folding) intelligent
    • Et bien plus...

  DIFFÉRENCE AVEC LA COLORATION CLASSIQUE :
    Regex-based syntax (ancien) : Colore "function" partout pareil
    Treesitter (moderne)        : Distingue la déclaration de fonction, l'appel, le mot-clé

  EXEMPLE :
    function hello()  -- "function" et "hello" colorés différemment
        hello()       -- "hello" ici est coloré comme un appel de fonction
    end

  NOTE: Treesitter télécharge automatiquement les parseurs pour chaque langage.
        Les parseurs sont des fichiers .so compilés.

  Voir :help nvim-treesitter pour la documentation complète
--]]

return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
            auto_install = true,
        })
    end,
}

-- [[ TODO: Modules Treesitter Supplémentaires ]]
--
--  Treesitter offre bien plus que la coloration et la sélection !
--  Voici des modules supplémentaires à explorer :
--
--  MODULES INTÉGRÉS (activables dans setup()) :
--    • indent : Indentation automatique intelligente basée sur l'AST
--        indent = { enable = true }
--
--    • fold : Pliage de code basé sur la structure syntaxique
--        Nécessite : vim.opt.foldmethod = 'expr' et vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--
--  PLUGINS ADDITIONNELS POPULAIRES :
--    • nvim-treesitter-textobjects : Objets textuels (sélectionner fonctions, classes, etc. avec des commandes)
--        Exemple : "vif" sélectionne l'intérieur d'une fonction
--
--    • nvim-treesitter-context : Affiche le contexte (fonction/classe courante) en haut de l'écran
--
--    • nvim-ts-rainbow : Colore les parenthèses/brackets par paires avec des couleurs différentes
--
--    • nvim-ts-autotag : Ferme automatiquement les balises HTML/XML
--
--  COMMANDES UTILES :
--    :TSInstall <langage>    - Installe un parseur manuellement
--    :TSInstallInfo          - Liste tous les parseurs disponibles
--    :TSUpdate              - Met à jour tous les parseurs installés
--    :TSUninstall <langage> - Désinstalle un parseur
--    :InspectTree           - Affiche l'arbre syntaxique du fichier (utile pour déboguer)
--
--  Voir :help nvim-treesitter-modules pour tous les modules disponibles
