local util = require 'util'
local http = require 'http'

PROPRIEDADE_NOME = 'gru'

local URL = "https://dl.dropbox.com/s/k71k8rmp2hd2r86/TempSun.txt?dl=1"

function handler (e)

	if (e.class == 'ncl' and e.type == 'presentation' and e.action=='start') then
		print('Image Start')
		readTextFromHtml(URL)
	end

end


function readTextFromHtml(url)
	print("Accessing:", url) io.flush()

	http.request(url, display)
end


--Function callback
--header: Response http header
--body: The response body (in this case, text)
function display(header, body)

	print("Value read:", body) io.flush()

	geraEventoDeAtriuicao(PROPRIEDADE_NOME, body)

end


function geraEventoDeAtriuicao(nomePropriedade, valor)

		evt = {
			class    = 'ncl',
			type     = 'attribution',
			action   = 'start',
			name	 = nomePropriedade,
			value    = tonumber(valor),
		}

		event.post(evt) -- evento de inicio da atribuicao
		evt.action = 'stop'
		event.post(evt) -- evento de final da atribuicao

		print('Evento de atribuicao gerado:', evt.value) io.flush()
end


event.register(handler)
