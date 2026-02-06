--[[
============================================================================================
    ROSLYN.NVIM - SERVEUR LSP C# MODERNE + RAZOR/BLAZOR (COHOSTING)
============================================================================================

  QU'EST-CE QUE ROSLYN ?
  ----------------------
  Roslyn est le compilateur C# officiel de Microsoft et son serveur LSP. C'est le même
  serveur utilisé par Visual Studio Code pour le support C#. Il remplace OmniSharp qui
  n'est plus maintenu activement.

  POURQUOI ROSLYN PLUTÔT QU'OMNISHARP ?
    • Activement maintenu par Microsoft
    • Même serveur que VSCode (garantit la compatibilité)
    • Support des dernières fonctionnalités C# (.NET 8+)
    • Support des fichiers générés par le compilateur (source generators)
    • Gestion intelligente de multiples solutions (.sln)
    • Actions de code avancées (Fix All, nested code actions)

  SUPPORT RAZOR/BLAZOR (COHOSTING) :
    Depuis fin 2025, roslyn.nvim intègre directement le support Razor/CSHTML via
    le mécanisme de co-hosting. Cela remplace l'ancien plugin rzls.nvim (archivé).
    Plus besoin de plugin séparé ni de handlers spéciaux pour Razor.

  PRÉREQUIS :
    • Neovim >= 0.11.0
    • .NET SDK installé avec la commande `dotnet` disponible
    • Roslyn installé via Mason (voir instructions ci-dessous)

  INSTALLATION DU SERVEUR ROSLYN :
    1. Redémarrez Neovim après avoir ajouté ce fichier
    2. Le registre Mason personnalisé sera configuré automatiquement
    3. Exécutez :MasonInstall roslyn
    4. Le serveur sera téléchargé et configuré automatiquement

  COMMANDES ROSLYN :
    :Roslyn start    - Démarre le serveur Roslyn
    :Roslyn stop     - Arrête le serveur Roslyn
    :Roslyn restart  - Redémarre le serveur Roslyn
    :Roslyn target   - Change de solution .sln (si plusieurs dans le projet)

  Voir :help roslyn.nvim pour plus d'informations
--]]

return {
    "seblyng/roslyn.nvim",

    -- Roslyn se déclenche sur les fichiers C# et Razor/CSHTML (cohosting)
    ft = { "cs", "razor" },

    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        -- Gestion du file watching (surveillance des changements de fichiers)
        -- "auto" : laisse Roslyn décider (recommandé)
        -- "roslyn" : désactive le filewatching côté Neovim
        -- "off" : désactive toute surveillance (économise des ressources)
        filewatching = "auto",

        -- Recherche élargie : cherche les .sln dans les dossiers parents
        broad_search = false,

        -- Verrouille la solution sélectionnée après le premier attachement
        lock_target = false,

        -- Mode silencieux : désactive les notifications d'initialisation
        silent = false,
    },

    config = function(_, opts)
        -- [[ Configuration LSP pour Roslyn ]]
        -- vim.lsp.config configure les paramètres du serveur LSP (settings, on_attach, etc.)
        -- Ces réglages sont séparés des options du plugin roslyn.nvim
        vim.lsp.config("roslyn", {
            settings = {
                -- [[ Inlay Hints - Indices visuels inline ]]
                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                    csharp_enable_inlay_hints_for_types = true,
                    dotnet_enable_inlay_hints_for_indexer_parameters = true,
                    dotnet_enable_inlay_hints_for_literal_parameters = true,
                    dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                    dotnet_enable_inlay_hints_for_other_parameters = true,
                    dotnet_enable_inlay_hints_for_parameters = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                },

                -- [[ Code Lens - Références et tests inline ]]
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                    dotnet_enable_tests_code_lens = true,
                },

                -- [[ Complétion ]]
                ["csharp|completion"] = {
                    dotnet_provide_regex_completions = true,
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                    dotnet_show_name_completion_suggestions = true,
                },

                -- [[ Analyse en arrière-plan ]]
                ["csharp|background_analysis"] = {
                    dotnet_analyzer_diagnostics_scope = "fullSolution",
                    dotnet_compiler_diagnostics_scope = "fullSolution",
                },

                -- [[ Recherche de symboles ]]
                ["csharp|symbol_search"] = {
                    dotnet_search_reference_assemblies = true,
                },

                -- [[ Formatage ]]
                ["csharp|formatting"] = {
                    dotnet_organize_imports_on_format = true,
                },
            },
        })

        require("roslyn").setup(opts)
    end,
}
