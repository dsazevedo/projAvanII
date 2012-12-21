local util = require 'util'
local http = require 'http'

PROPRIEDADE_NOME_GRU = 'gru'
PROPRIEDADE_NOME_POA = 'poa'
PROPRIEDADE_NOME_JPA = 'jpa'

local GRU = "https://dl.dropbox.com/s/ylm43hs9hdyp17v/gru.txt?dl=1"
local POA = "https://dl.dropbox.com/s/p9dj4ierwjcgo8k/poa.txt?dl=1"
local JPA = "https://dl.dropbox.com/s/ue8huhidjuswrpg/jpa.txt?dl=1"

function handler (e)

	if (e.class == 'ncl' and e.type == 'presentation' and e.action=='start') then
		print('imagem1 iniciada')
		readTextFromHtml(GRU, POA, JPA)		
	end

end


function readTextFromHtml(url1, url2, url3)
	print("<><> Acessando:", url) io.flush()

	http.request(url1, display_GRU)
	http.request(url2, display_POA)
	http.request(url3, display_JPA)
end


--funcao callback
--header: cabecalho da resposta do http
--body: corpo da resposta (neste caso, texto)
function display_GRU(header, body)

	print("<><> valor lido:", body) io.flush()

	geraEventoDeAtribuicao(PROPRIEDADE_NOME_GRU, body)	

end

function display_POA(header, body)

	print("<><> valor lido:", body) io.flush()

	geraEventoDeAtribuicao(PROPRIEDADE_NOME_POA, body)	

end

function display_JPA(header, body)

	print("<><> valor lido:", body) io.flush()

	geraEventoDeAtribuicao(PROPRIEDADE_NOME_JPA, body)	

end

function geraEventoDeAtribuicao(nomePropriedade, valor)

		evt = {
			class    = 'ncl',
			type     = 'attribution',
			action   = 'start',
			name	 = nomePropriedade,
			value    = valor,
		}

		event.post(evt) -- evento de inicio da atribuicao
		evt.action = 'stop'
		event.post(evt) -- evento de final da atribuicao

		print('Evento de atribuicao gerado:', evt.value) io.flush()
end


event.register(handler)
