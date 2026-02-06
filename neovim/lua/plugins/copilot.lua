--[[
============================================================================================
    GITHUB COPILOT - ASSISTANT DE CODE IA
============================================================================================

  QU'EST-CE QUE GITHUB COPILOT ?
  -------------------------------
  GitHub Copilot est un assistant de programmation alimenté par l'IA qui suggère
  du code en temps réel pendant que vous tapez. Il est basé sur OpenAI Codex et
  a été entraîné sur des milliards de lignes de code open source.

  FONCTIONNALITÉS PRINCIPALES :
    • Suggestions de code contextuelles (complète des lignes entières ou des fonctions)
    • Support de dizaines de langages de programmation
    • Génération de fonctions à partir de commentaires
    • Suggestions alternatives (plusieurs propositions pour le même contexte)
    • Complétion de tests unitaires
    • Documentation et commentaires automatiques

  PRÉREQUIS :
    • Compte GitHub avec abonnement Copilot actif
      (Gratuit pour les étudiants et contributeurs open source)
    • Authentification requise au premier lancement

  PREMIÈRE UTILISATION :
    1. Redémarrez Neovim après l'installation du plugin
    2. Exécutez :Copilot setup
    3. Suivez les instructions pour vous authentifier avec GitHub
    4. Un code sera affiché : copiez-le et collez-le sur le site GitHub
    5. Copilot sera activé et commencera à suggérer du code !

  RACCOURCIS CLAVIER PAR DÉFAUT :
    <Tab>          - Accepter la suggestion
    <C-]>          - Rejeter la suggestion
    <M-]>          - Suggestion suivante (Alt + ])
    <M-[>          - Suggestion précédente (Alt + [)
    <C-CR>         - Ouvrir le panneau de suggestions multiples

  COMMANDES UTILES :
    :Copilot setup       - Configurer l'authentification GitHub
    :Copilot enable      - Activer Copilot
    :Copilot disable     - Désactiver Copilot temporairement
    :Copilot status      - Vérifier l'état de Copilot

  ASTUCE D'UTILISATION :
    • Écrivez des commentaires descriptifs : Copilot génère du code à partir du contexte
      Exemple : Tapez "// Fonction pour calculer la factorielle" et attendez la suggestion

    • Commencez à taper une fonction : Copilot complète automatiquement
      Exemple : Tapez "function isPrime(" et Copilot suggérera l'implémentation

    • Acceptez partiellement : Si la suggestion est trop longue, acceptez mot par mot avec <C-Right>

  NOTE: Copilot envoie votre code à GitHub pour générer des suggestions.
        Vérifiez la politique de votre entreprise avant de l'utiliser sur du code propriétaire.

  Voir :help copilot pour la documentation complète
--]]

return {
    -- Plugin Copilot officiel de GitHub (version Vim/Neovim)
    -- NOTE: Il existe aussi copilot.lua (alternative Lua native) mais copilot.vim
    --       est le plugin officiel et le plus stable.
    'github/copilot.vim',

    -- TODO: Configuration personnalisée de Copilot
    --   Vous pouvez personnaliser Copilot en ajoutant une fonction config :
    --
    -- config = function()
    --     -- Personnaliser les keybindings si vous n'aimez pas les défauts
    --     vim.g.copilot_no_tab_map = true  -- Désactiver Tab pour accepter
    --     vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
    --         expr = true,
    --         replace_keycodes = false,
    --         desc = "Accepter la suggestion Copilot"
    --     })
    --
    --     -- Désactiver Copilot pour certains types de fichiers
    --     vim.g.copilot_filetypes = {
    --         ["*"] = true,
    --         ["gitcommit"] = false,      -- Pas de suggestions dans les messages de commit
    --         ["markdown"] = false,       -- Pas de suggestions dans les fichiers markdown
    --     }
    -- end
}

-- [[ TODO: Alternatives et Améliorations ]]
--
--  ALTERNATIVE MODERNE :
--    • copilot.lua + copilot-cmp : Version Lua native avec intégration nvim-cmp
--        Permet d'avoir les suggestions Copilot dans le menu d'autocomplétion
--
--  PLUGINS COMPLÉMENTAIRES :
--    • CopilotChat.nvim : Interface de chat avec Copilot dans Neovim
--        Permet de poser des questions et d'obtenir des explications sur le code
--
--  AUTRES ASSISTANTS IA :
--    • codeium.vim : Alternative gratuite à Copilot (pas besoin d'abonnement)
--    • tabnine-nvim : Autre assistant IA avec un modèle d'entraînement différent
--
--  NOTE: Si Copilot ne fonctionne pas :
--    1. Vérifiez votre statut : :Copilot status
--    2. Vérifiez votre authentification : :Copilot setup
--    3. Vérifiez que vous avez une connexion internet
--    4. Consultez les logs : :messages
