<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="part1" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="rgTV">
				<region id="rgTVTelaInteira" />
				<region id="rgBotao" right="5%" top="5%" width="200" height="230" zIndex="3" />
				<region id="rgTemp" right="5%" top="5%" width="200" height="230" zIndex="3" />
			</region>
		</regionBase>

		<descriptorBase>
			<descriptor id="dTVtelaInteira" region="rgTVTelaInteira" />
			<descriptor id="dBotao" region="rgBotao">
				<descriptorParam name="transparency" value="10%" />
			</descriptor>
			<descriptor id="dTemp" region="rgTemp" explicitDur="5s">
				<descriptorParam name="fontSize" value="40" />
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
		<media id="gru" src="../media/gru.txt" descriptor="dTemp"/>
		<media id="poa" src="../media/poa.txt" descriptor="dTemp"/>
		<media id="jpa" src="../media/jpa.txt" descriptor="dTemp"/>
			
		<link xconnector="connectors#onBeginStartNDelayStopN">
			<linkParam name="delay" value="10s"/>
			<bind role="onBegin" component="videoAbertura" />
			<bind role="start" component="info" />
			<bind role="stop" component="info" />
			
		</link>
		
		<link xconnector="connectors#onEndStart">
			<bind role="stop" component="info" />
			<bind role="onEnd" component="info" />
			<bind role="start" component="gru" />
		</link>
		<link xconnector="connectors#onEndStopNStartN">
			<bind role="start" component="poa" />
			<bind role="onEnd" component="gru" />
			<bind role="stop" component="gru" />
		</link>
		<link xconnector="connectors#onEndStopNStartN">
			<bind role="start" component="jpa" />
			<bind role="onEnd" component="poa" />
			<bind role="stop" component="poa" />
		</link>
		<link xconnector="connectors#onEndStart">
			<bind role="start" component="info" />
			<bind role="onEnd" component="jpa" />
			<bind role="stop" component="jpa" />
		</link>
	
		<link id="lVideoPrincTermina" xconnector="connectors#onEndAbort">
			<bind role="abort" component="info" />
			<bind role="onEnd" component="videoAbertura" />
		</link>
		
	</body>
</ncl>