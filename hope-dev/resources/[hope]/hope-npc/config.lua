Config = {}

Config.Key = 38 -- [E] Chave para abrir a interação, confira aqui o ID das chaves: https://docs.fivem.net/docs/game-references/controls/#controls

Config.AutoCamPosition = true -- Se for verdade, definirá a posição da câmera automaticamente

Config.AutoCamRotation = true -- Se for verdade, a rotação da câmera será definida automaticamente

Config.HideMinimap = true -- Se for verdade, ocultará o minimapa ao interagir com um NPC

Config.UseOkokTextUI = false -- Se Usa okoktextui

Config.CameraAnimationTime = 1000 -- Animação da Camera Tempo: 1000 = 1 Segundo

Config.TalkToNPC = {
	{
		npc = 'u_m_y_abner', 										-- Site também veja o nome do peds: https://wiki.rage.mp/index.php?title=Peds
		header = 'Funcionário do', 									-- Texto sobre o nome
		name = 'Banco Hope', 										-- Texto sob o cabeçalho
		uiText = "Funcionário do Banco Hope",						-- Nome mostrado na notificação quando próximo ao NPC
		dialog = 'Ei, como posso te ajudar?',						-- Texto exibido no balão de mensagem
		coordinates = vector3(254.17, 222.8, 105.3), 				-- coordenadas do NPC
		heading = 160.0,											-- Título do NPC (precisa de decimais, 0,0 por exemplo)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Posição da câmera em relação ao NPC | (só funciona se Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Rotação da câmera | (só funciona if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- Até onde o jogador pode interagir com o NPC
		options = {													-- Opções mostradas ao interagir (Máximo de 6 opções por NPC)
			{'Você Deseja fazer um depósito ou saque?', 'bank:openSystem', 'c'},		-- 'c' para client
			{'Quero receber meu pagamento"', 'vRP:receiveSalary', 's'},		-- 's' para server (se você escrever outra coisa, será servidor por padrão)
			-- {"I want to access my safe.", 'okokTalk:safe', 'c'}, 
			-- {"I want to make a new credit card.", 'okokTalk:card', 'c'}, 
			-- {"I lost my credit card.", 'okokTalk:lost', 'c'}, 
			-- {"Is Jennifer working?", 'okokTalk:jennifer', 'c'}, 
		},
		jobs = {													-- Trabalhos que podem interagir com o NPC
			
		},
	},
}