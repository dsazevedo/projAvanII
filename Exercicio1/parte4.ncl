<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="parte4" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<!--Author: Diego Sousa - diego@diegosousa.com-->
	<head>
		<regionBase>
			<region id="rVideoPrincipal" height="100%" width="100%"/>
			<region id="rIconeInteratividade" right="5%" top="1%" width="200" height="230" zIndex="2"/>
			<region id="rMenu" right="5%" top="1%" width="200" height="230" zIndex="2"/>
			<region id="rTemp" right="1%" top="10%" width="200" height="230" zIndex="2"/>
		</regionBase>
		
		<descriptorBase>
			<descriptor id="dVideoPrincipal" region="rVideoPrincipal"/>
			<descriptor id="dIconeInteratividade" region="rIconeInteratividade"/>
			<descriptor id="dMenu" region="rMenu"/>
			<descriptor id="dtemp" region="rTemp">
				<descriptorParam name="fontSize" value="45"/>
			</descriptor>
		</descriptorBase>
		
		<connectorBase>
			<importBase alias="connectors" documentURI="../ConnectorBase.ncl"/>
			<causalConnector id="onEndAttributionSet">
				<connectorParam name="value"/>
				<simpleCondition role="onEndAttribution"/>				
				<simpleAction role="set" value="$value"/>				
			</causalConnector>			
			
			<causalConnector id="jpaToGru">
				<connectorParam name="vKey"/>
				<connectorParam name="vState"/>
				<connectorParam name="var"/>				
				<compoundCondition operator="and">
					<simpleCondition role="onSelection" key="$vKey"/>
					<simpleCondition role="onEndAttribution" max="unbounded"/>										
					<assessmentStatement comparator="eq">
						<attributeAssessment role="test" eventType="presentation" attributeType="state"/>
						<valueAssessment value="$vState"/>
					</assessmentStatement>										
				</compoundCondition>				
				<compoundAction operator="par">
					<simpleAction role="start" max="unbounded"/>
					<simpleAction role="set" value="$var" max="unbounded"/>
					<simpleAction role="stop"/>					
				</compoundAction>				
			</causalConnector>			
									
			<causalConnector id="onKeySelection_and_NodeStateTestStartStop">
				<connectorParam name="vKey"/>
				<connectorParam name="vState"/>
				<connectorParam name="var"/>				
				<compoundCondition operator="and">
					<simpleCondition role="onSelection" key="$vKey"/>
					<simpleCondition role="onEndAttribution" max="unbounded"/>					
					<assessmentStatement comparator="eq">
						<attributeAssessment role="test" eventType="presentation" attributeType="state"/>
						<valueAssessment value="$vState"/>
					</assessmentStatement>										
				</compoundCondition>				
				<compoundAction operator="par">
					<simpleAction role="set" value="$var" max="unbounded"/>
					<simpleAction role="stop" max="unbounded"/>
				</compoundAction>				
			</causalConnector>			
		</connectorBase>
	</head>
	<body>
		<port id="pVideoPrincipal" component="mVideoPrincipal"/>
		
		<media id="mVideoPrincipal" src="../media/480-cnn.mp4" descriptor="dVideoPrincipal"/>
		<media id="mMenu" src="../media/menu.png" descriptor="dMenu"/>
		<media id="mInteratividade" src="../media/interactive.png" descriptor="dIconeInteratividade"/>
		<media id="mTempGRU" src="../media/gru.txt" descriptor="dtemp"/>
		<media id="mTempPOA" src="../media/poa.txt" descriptor="dtemp"/>
		<media id="mTempJPA" src="../media/jpa.txt" descriptor="dtemp"/>
		<media id="leitorDeMensagemGRU" src="../script/readTextFromHtmlGRU.lua">
			<property name="gru"/>
		</media>
		<media id="leitorDeMensagemPOA" src="../script/readTextFromHtmlPOA.lua">
			<property name="poa"/>
		</media>
		<media id="leitorDeMensagemJPA" src="../script/readTextFromHtmlJPA.lua">
			<property name="jpa"/>
		</media>
		<media id="exibidorDeTextoGRU" src="../script/show-text-from-set-propertyGRU.lua" descriptor="dtemp">
			<property name="texto"/>
		</media>		
		<media id="exibidorDeTextoJPA" src="../script/show-text-from-set-propertyJPA.lua" descriptor="dtemp">
			<property name="texto"/>
		</media>
		<media id="exibidorDeTextoPOA" src="../script/show-text-from-set-propertyPOA.lua" descriptor="dtemp">
			<property name="texto"/>
		</media>
		
		
		<!--Starts Movie and icon of interactive -->
		<link xconnector="connectors#onBeginStart">
			<bind role="onBegin" component="mVideoPrincipal"/>
			<bind role="start" component="mInteratividade"/>
			<bind role="start" component="exibidorDeTextoGRU"/>
			<bind role="start" component="exibidorDeTextoJPA"/>
			<bind role="start" component="leitorDeMensagemGRU"/>
			<bind role="start" component="leitorDeMensagemJPA"/>				
		</link>		
		
		<link xconnector="onKeySelection_and_NodeStateTestStartStop">
			<bind role="onEndAttribution" component="leitorDeMensagemGRU" interface="gru"/>
			<bind role="onSelection" component="mVideoPrincipal">
				<bindParam name="vKey" value="BLUE"/>
			</bind>
			<bind role="test" component="mInteratividade">
				<bindParam name="vState" value="occurring"/>
			</bind>
			<bind role="msg" component="leitorDeMensagemGRU" interface="gru"/>
			<bind role="set" component="exibidorDeTextoGRU" interface="texto">
				<bindParam name="var" value="$msg"/>
			</bind>							
			<bind role="stop" component="mInteratividade"/>
		</link>	
		
		<!--Connector Key Selection = CURSOR_RIGHT, then exchange the temperatures in the direction (GRU -> JPA -> POA)-->
		
		<link xconnector="onKeySelection_and_NodeStateTestStartStop">
			<bind role="onEndAttribution" component="leitorDeMensagemJPA" interface="jpa"/>
			<bind role="onSelection" component="leitorDeMensagemGRU">
				<bindParam name="vKey" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="test" component="leitorDeMensagemGRU">
				<bindParam name="vState" value="occurring"/>
			</bind>
			<bind role="msg" component="leitorDeMensagemJPA" interface="jpa"/>
			<bind role="set" component="exibidorDeTextoJPA" interface="texto">
				<bindParam name="var" value="$msg"/>
			</bind>							
			<bind role="stop" component="leitorDeMensagemGRU"/>
			<bind role="stop" component="exibidorDeTextoGRU"/>
		</link>	
		
		<!--
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="stop" component="exibidorDeTexto"/>
			<bind role="onSelection" component="exibidorDeTexto">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="start" component="mTempJPA"/>
		</link>
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="stop" component="mTempJPA"/>
			<bind role="onSelection" component="mTempJPA">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>
			<bind role="start" component="mTempPOA"/>
		</link> -->
		<!--Connector Key Selection = CURSOR_LEFT, then return the temperatures in the direction (GRU <- JPA <- POA)				
		
		 <link xconnector="jpaToGru">					
			<bind role="onSelection" component="mTempJPA">
				<bindParam name="vKey" value="CURSOR_LEFT"/>
			</bind>
			<bind role="test" component="mTempJPA">
				<bindParam name="vState" value="occurring"/>
			</bind>
			<bind role="msg" component="leitorDeMensagemGRU" interface="gru"/>
			<bind role="set" component="exibidorDeTexto" interface="texto">
				<bindParam name="var" value="$msg"/>
			</bind>
			<bind role="start" component="exibidorDeTexto"/>				
			<bind role="stop" component="mTempJPA"/>				
		</link>-->		
											
		<!--Connector Key Selection = Red, then return the execution of Movie and icon of interactive-->
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="stop" component="mTempGRU"/>
			<bind role="onSelection" component="mTempGRU">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="start" component="mVideoPrincipal"/>
			<bind role="start" component="mInteratividade"/>
		</link>
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="stop" component="mTempJPA"/>
			<bind role="onSelection" component="mTempJPA">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="start" component="mVideoPrincipal"/>
			<bind role="start" component="mInteratividade"/>
		</link>
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="stop" component="mTempPOA"/>
			<bind role="onSelection" component="mTempPOA">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="start" component="mVideoPrincipal"/>
			<bind role="start" component="mInteratividade"/>
		</link>						
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="stop" component="mTempPOA"/>
			<bind role="onSelection" component="mTempPOA">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>
			<bind role="start" component="mTempJPA"/>
		</link>
		<link xconnector="connectors#onEndAbort">
			<bind role="onEnd" component="mVideoPrincipal"/>
			<bind role="abort" component="mMenu"/>
			<bind role="abort" component="mInteratividade"/>
			<bind role="abort" component="mTempGRU"/>
			<bind role="abort" component="mTempPOA"/>
			<bind role="abort" component="mTempJPA"/>
			<bind role="abort" component="leitorDeMensagemGRU"/>
			<bind role="abort" component="leitorDeMensagemPOA"/>
			<bind role="abort" component="leitorDeMensagemJPA"/>
			<bind role="abort" component="exibidorDeTextoGRU"/>
			<bind role="abort" component="exibidorDeTextoJPA"/>
		</link>
	</body>
</ncl>