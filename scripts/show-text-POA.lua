-- CONFIGURA��ES
fontFace = 'vera'
fontSize = 40
fontColor = "white"
bgcolor = 'black'

-- EVENTOS
PROPRIEDADE_NOME = 'textoPOA'

function handler(e)

	print('recebendo evento...', e.class) io.flush()

	if (e.class == 'ncl' and e.type == 'attribution') then
		if e.name == PROPRIEDADE_NOME then
			-- e.value contem o valor atribuido a propriedade

			print('Valor sendo atribuindo:', e.value) io.flush()
			exibeTexto(e.value)
		end
	end
end


function exibeTexto(texto)
	-- apaga o canvas
	--width, height = canvas:attrSize()
	--canvas:attrColor(0,0,0,255)
	--canvas:drawRect('fill', 0,0, width,height)

	--canvas:attrCrop (canvas:attrCrop ())
	-- desenha o texto
	canvas:attrFont(fontFace, fontSize)
	canvas:attrColor(fontColor)
	canvas:drawText(0,0, texto)

	canvas:flush()

end



event.register(handler)