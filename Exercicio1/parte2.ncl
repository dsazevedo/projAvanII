<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="part2" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="rgTV">
				<region id="rgTVTelaInteira" />
				<region id="rgBotao" right="5%" top="5%" width="200" height="230" zIndex="3" />
				<region id="rgTemp" right="5%" top="5%" width="200" height="230" zIndex="3" />
				<region id="rgMenu" right="5%" top="5%" width="200" height="230" zIndex="5" />
			</region>
		</regionBase>

		<descriptorBase>
			<descriptor id="dTVtelaInteira" region="rgTVTelaInteira" />
			<descriptor id="dBotao" region="rgBotao">
				<descriptorParam name="transparency" value="10%" />
			</descriptor>
			<descriptor id="dTemp" region="rgTemp">
				<descriptorParam name="fontSize" value="40" />
			</descriptor>
			<descriptor id="dMenu" region="rgMenu">
				<descriptorParam name="transparency" value="15%"/>
			</descriptor>
			<descriptor id="dOpt1">
				
			</descriptor>
			<descriptor id="dOpt2">
				
			</descriptor>
			<descriptor id="dOpt3">
				
			</descriptor>
		</descriptorBase>
		
		<connectorBase>
			<importBase alias="connectors" documentURI="../ConnectorBase.ncl"/>
		</connectorBase>

	</head>

	<body>
		<port id="pVideoAbertura" component="videoAbertura" />
			
		<media id="videoAbertura" src="../media/480-cnn.mp4" descriptor="dTVtelaInteira" />
		<media id="info" src="../media/interactive.png" descriptor="dBotao"/>
		<media id="menu" src="../media/menu.png" descriptor="dMenu" />
		<media id="gru" src="../media/gru.txt" descriptor="dTemp"/>
		<media id="poa" src="../media/poa.txt" descriptor="dTemp"/>
		<media id="jpa" src="../media/jpa.txt" descriptor="dTemp"/>
		
		<link xconnector="connectors#onBeginStart">
			<bind role="onBegin" component="videoAbertura" />
			<bind role="start" component="info" />
		</link>
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="stop" component="info" />
			<bind role="onSelection" component="info">
				<bindParam name="keyCode" value="BLUE"/>
			</bind>
			<bind role="start" component="menu" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="menu">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="start" component="info" />
			<bind role="stop" component="menu" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="menu">
				<bindParam name="keyCode" value="1"/>
			</bind>
			<bind role="start" component="gru" />
			<bind role="stop" component="menu" />
		</link>
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="menu">
				<bindParam name="keyCode" value="2"/>
			</bind>
			<bind role="start" component="poa" />
			<bind role="stop" component="menu" />
		</link>
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="menu">
				<bindParam name="keyCode" value="3"/>
			</bind>
			<bind role="start" component="jpa" />
			<bind role="stop" component="menu" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="gru">
				<bindParam name="keyCode" value="GREEN"/>
			</bind>
			<bind role="stop" component="gru" />
			<bind role="start" component="menu" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="poa">
				<bindParam name="keyCode" value="GREEN"/>
			</bind>
			<bind role="stop" component="poa" />
			<bind role="start" component="menu" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="jpa">
				<bindParam name="keyCode" value="GREEN"/>
			</bind>
			<bind role="stop" component="jpa" />
			<bind role="start" component="menu" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="gru">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="stop" component="gru" />
			<bind role="start" component="info" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="poa">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="stop" component="poa" />
			<bind role="start" component="info" />
		</link>
		
		<link xconnector="connectors#onKeySelectionStartNStopN">
			<bind role="onSelection" component="jpa">
				<bindParam name="keyCode" value="RED"/>
			</bind>
			<bind role="stop" component="jpa" />
			<bind role="start" component="info" />
		</link>
	
		<link id="lVideoPrincTermina" xconnector="connectors#onEndAbortN">
			<bind role="abort" component="info" />
			<bind role="abort" component="menu" />
			<bind role="abort" component="gru" />
			<bind role="abort" component="jpa" />
			<bind role="abort" component="poa" />
			<bind role="onEnd" component="videoAbertura" />
		</link>
		

	</body>
</ncl>