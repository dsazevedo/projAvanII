<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="parte2" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="rVideoPrincipal" height="100%" width="100%"/>
			<region id="rIconeInteratividade" right="5%" top="1%" width="200" height="230" zIndex="2"/>
			<region id="rMenu" right="5%" top="1%" width="200" height="230" zIndex="2"/>
			<region id="rTempGRU" right="1%" top="10%" width="200" height="230" zIndex="2"/>
			<region id="rTempPOA" right="1%" top="10%" width="200" height="230" zIndex="2"/>
			<region id="rTempJPA" right="1%" top="10%" width="200" height="230" zIndex="2"/>					
		</regionBase>
				
		<descriptorBase>
			<descriptor id="dVideoPrincipal" region="rVideoPrincipal"/>
			<descriptor id="dIconeInteratividade" region="rIconeInteratividade"/>
			<descriptor id="dMenu" region="rMenu"/>
			<descriptor id="dTemGRU" region="rTempGRU">
				<descriptorParam name="fontSize" value="45"/>				
			</descriptor>				
			<descriptor id="dTemPOA" region="rTempPOA">
				<descriptorParam name="fontSize" value="45"/>				
			</descriptor>				
			<descriptor id="dTemJPA" region="rTempJPA">
				<descriptorParam name="fontSize" value="45"/>				
			</descriptor>
		</descriptorBase>
		
		<connectorBase>
			<causalConnector id="onKeySelectionStartNStopN">
				<connectorParam name="keyCode"/>
				<simpleCondition role="onSelection" key="$keyCode"/>
				<compoundAction operator="seq">
					<simpleAction role="start" max="unbounded" qualifier="par"/>
					<simpleAction role="stop" max="unbounded" qualifier="par"/>
				</compoundAction>
			</causalConnector>
			
			<causalConnector id="onBeginStart">
				<simpleCondition role="onBegin"/>
				<simpleAction role="start"/>
			</causalConnector>
			
			<causalConnector id="onEndStop">
				<simpleCondition role="onEnd"/>
				<simpleAction role="stop"/>
			</causalConnector>
		</connectorBase>
	</head>
	<body>
		<port id="pVideoPrincipal" component="mVideoPrincipal"/>
		
		<media id="mVideoPrincipal" src="../media/480-cnn.mp4" descriptor="dVideoPrincipal"/>
		<media id="mMenu" src="../media/menu.png" descriptor="dMenu"/>
		<media id="mInteratividade" src="../media/interactive.png" descriptor="dIconeInteratividade"/>
		<media id="mTempGRU" src="../media/gru.txt" descriptor="dTemGRU"/>
		<media id="mTempPOA" src="../media/poa.txt" descriptor="dTemPOA"/>
		<media id="mTempJPA" src="../media/jpa.txt" descriptor="dTemJPA"/>		
		
		<!-- Inicia o Video Principal e junto o icone de interatividade-->		
		<link xconnector="onBeginStart">
			<bind role="onBegin" component="mVideoPrincipal"/>
			<bind role="start" component="mInteratividade"/>
		</link>		
		<!-- Retira o icone de interação e inicia o menu -->
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="stop" component="mInteratividade"/>
			<bind role="onSelection" component="mInteratividade">
				<bindParam name="keyCode" value="BLUE"/>
			</bind>
			<bind role="start" component="mMenu"/>
		</link>				
		<!-- Retira o menu e inicia o icone de interação-->
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mMenu">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="start" component="mInteratividade"/>
			<bind role="stop" component="mMenu"/>
		</link>
		<!-- Ação para escolha da temperatura-->
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mMenu">
				<bindParam name="keyCode" value="1"/>
			</bind>
			<bind role="start" component="mTempGRU"/>
			<bind role="stop" component="mMenu"/>
		</link>
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mMenu">
				<bindParam name="keyCode" value="2"/>
			</bind>
			<bind role="start" component="mTempPOA"/>
			<bind role="stop" component="mMenu"/>
		</link>
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mMenu">
				<bindParam name="keyCode" value="3"/>
			</bind>
			<bind role="start" component="mTempJPA"/>
			<bind role="stop" component="mMenu"/>
		</link>				
		<!-- Apaga a temperatura e retorna para o menu-->						
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mTempGRU">
				<bindParam name="keyCode" value="GREEN"/>
			</bind>
			<bind role="stop" component="mTempGRU"/>
			<bind role="start" component="mMenu"/>
		</link>
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mTempPOA">
				<bindParam name="keyCode" value="GREEN"/>
			</bind>
			<bind role="stop" component="mTempPOA"/>
			<bind role="start" component="mMenu"/>
		</link>
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mTempJPA">
				<bindParam name="keyCode" value="GREEN"/>
			</bind>
			<bind role="stop" component="mTempJPA"/>
			<bind role="start" component="mMenu"/>
		</link>
		<!-- Apaga a temperatura e retorna para o icone de interação-->
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mTempGRU">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="stop" component="mTempGRU"/>
			<bind role="start" component="mInteratividade"/>
		</link>
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mTempPOA">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="stop" component="mTempPOA"/>
			<bind role="start" component="mInteratividade"/>
		</link>
		<link xconnector="onKeySelectionStartNStopN">
			<bind role="onSelection" component="mTempJPA">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="stop" component="mTempJPA"/>
			<bind role="start" component="mInteratividade"/>
		</link>
	</body>
</ncl>