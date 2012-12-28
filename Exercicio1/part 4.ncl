<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="part4" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<!--Author: Diego Sousa - diego@diegosousa.com-->
	<head>
		<regionBase>
			<region id="rMovie" height="100%" width="100%"/>
			<region id="rInteractivity" right="5%" top="1%" width="200" height="230" zIndex="2"/>
			<region id="rMenu" right="5%" top="1%" width="200" height="230" zIndex="2"/>
			<region id="rImg" right="1%" top="1%" width="70" height="70" zIndex="2"/>
			<region id="rTemp" left="78%" top="1%" zIndex="2"/>
			<region id="rCelsius" left="84%" top="1%" zIndex="2"/>					
			<region id="rCity" left="82%" top="10%" zIndex="2"/>							
		</regionBase>
		
		<descriptorBase>
			<descriptor id="dMovie" region="rMovie"/>
			<descriptor id="dInteractivity" region="rInteractivity"/>
			<descriptor id="dMenu" region="rMenu"/>
			<descriptor id="dtemp" region="rTemp"/>				
			<descriptor id="dImg" region="rImg"/>
			<descriptor id="dCity" region="rCity">
					<descriptorParam name="fontSize" value="35"/>				
			</descriptor>
			<descriptor id="dCelsius" region="rCelsius">
					<descriptorParam name="fontSize" value="35"/>				
			</descriptor>								
		</descriptorBase>
		
		<connectorBase>
			<importBase documentURI="../ConnectorBase.ncl" alias="connector"/>
		</connectorBase>
	</head>
	<body>
		<port id="pMovie" component="mMovie"/>
		
		<media id="mMovie" src="../media/Movie.mp4" descriptor="dMovie"/>
		<media id="mMenu" src="../media/menu.png" descriptor="dMenu"/>
		<media id="mInteractivity" src="../media/interactive.png" descriptor="dInteractivity"/>
		<media id="mImgSun" src="../media/sun.png" descriptor="dImg"/>
		<media id="mImgSnow" src="../media/snow.png" descriptor="dImg"/>
		<media id="mImgCloud" src="../media/cloud.png" descriptor="dImg"/>
		<media id="mCityGRU" src="../media/NameGru.txt" descriptor="dCity"/>
		<media id="mCityJPA" src="../media/NameJpa.txt" descriptor="dCity"/>
		<media id="mCityPOA" src="../media/NamePoa.txt" descriptor="dCity"/>
		<media id="mCelsius" src="../media/Celsius.txt" descriptor="dCelsius"/>		
		
		<media id="readTextFromHtmlGRU" src="../scripts/readTextFromHtmlGRU.lua">
			<property name="gru"/>
		</media>
		<media id="readTextFromHtmlJPA" src="../scripts/readTextFromHtmlJPA.lua">
			<property name="jpa"/>
		</media>
		<media id="readTextFromHtmlPOA" src="../scripts/readTextFromHtmlPOA.lua">
			<property name="poa"/>
		</media>
		<media id="showTempGRU" src="../scripts/show-text-GRU.lua" descriptor="dtemp">
			<property name="textoGRU"/>
		</media>
		<media id="showTempJPA" src="../scripts/show-text-JPA.lua" descriptor="dtemp">
			<property name="textoJPA"/>
		</media>
		<media id="showTempPOA" src="../scripts/show-text-POA.lua" descriptor="dtemp">
			<property name="textoPOA"/>
		</media>
		
		<!-- Rule 1: Start Movie and Image Interactivity -->
		<link xconnector="connector#onBeginStart">
			<bind role="onBegin" component="mMovie"/>
			<bind role="start" component="mInteractivity"/>
		</link>
		
		<!-- Rule 2: Show city temperature JPA -->
		<link xconnector="connector#onEndAttributionNOnSet">
			<bind role="onEndAttribution" component="readTextFromHtmlJPA" interface="jpa"/>
			<bind role="set" component="showTempJPA" interface="textoJPA">
				<bindParam name="var" value="$msg"/>
			</bind>
			<bind role="msg" component="readTextFromHtmlJPA" interface="jpa"/>
		</link>
		
		<!-- Rule 2.1: Show city temperature GRU -->
		<link xconnector="connector#onEndAttributionNOnSet">
			<bind role="onEndAttribution" component="readTextFromHtmlGRU" interface="gru"/>
			<bind role="set" component="showTempGRU" interface="textoGRU">
				<bindParam name="var" value="$msg"/>
			</bind>
			<bind role="msg" component="readTextFromHtmlGRU" interface="gru"/>
		</link>
		
		<!-- Rule 2.2: Show city temperature POA -->
		<link xconnector="connector#onEndAttributionNOnSet">
			<bind role="onEndAttribution" component="readTextFromHtmlPOA" interface="poa"/>
			<bind role="set" component="showTempPOA" interface="textoPOA">
				<bindParam name="var" value="$msg"/>
			</bind>
			<bind role="msg" component="readTextFromHtmlPOA" interface="poa"/>
		</link>
		
		<!-- Rule 3: Select Blue Key, then start temperature GRU -->
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="mInteractivity">
				<bindParam name="keyCode" value="BLUE"/>
			</bind>
			<bind role="stop" component="mInteractivity"/>		
			<bind role="start" component="readTextFromHtmlGRU"/>
			<bind role="start" component="showTempGRU"/>						
		</link>
		
		<!-- Rule 4: Select CURSOR_RIGHT Key, then start temperature JPA (GRU -> JPA) -->		
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="showTempGRU">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>				
			<bind role="stop" component="readTextFromHtmlGRU"/>
			<bind role="stop" component="showTempGRU"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>					
			<bind role="stop" component="mCityGRU"/>
			<bind role="stop" component="mCelsius"/>
			<bind role="start" component="readTextFromHtmlJPA"/>
			<bind role="start" component="showTempJPA"/>					
		</link>
		
		<!-- Rule 4.1: Select CURSOR_RIGHT Key, then start temperature POA (JPA -> POA) -->		
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="showTempJPA">
				<bindParam name="keyCode" value="CURSOR_RIGHT"/>
			</bind>				
			<bind role="stop" component="readTextFromHtmlJPA"/>
			<bind role="stop" component="showTempJPA"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>
			<bind role="stop" component="mCityJPA"/>
			<bind role="stop" component="mCelsius"/>				
			<bind role="start" component="readTextFromHtmlPOA"/>
			<bind role="start" component="showTempPOA"/>				
		</link>
		
		<!-- Rule 5: Select CURSOR_LEFT Key, then start temperature JPA (JPA <- POA) -->
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="showTempPOA">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>				
			<bind role="stop" component="readTextFromHtmlPOA"/>
			<bind role="stop" component="showTempPOA"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>	
			<bind role="stop" component="mCityPOA"/>
			<bind role="stop" component="mCelsius"/>			
			<bind role="start" component="readTextFromHtmlJPA"/>
			<bind role="start" component="showTempJPA"/>					
		</link>						
		
		<!-- Rule 5.1: Select CURSOR_LEFT Key, then start temperature GRU (GRU <- JPA) -->
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="showTempJPA">
				<bindParam name="keyCode" value="CURSOR_LEFT"/>
			</bind>				
			<bind role="stop" component="readTextFromHtmlJPA"/>
			<bind role="stop" component="showTempJPA"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>
			<bind role="stop" component="mCityJPA"/>
			<bind role="stop" component="mCelsius"/>				
			<bind role="start" component="readTextFromHtmlGRU"/>
			<bind role="start" component="showTempGRU"/>					
		</link>
			
		<!-- Rule 6: Checking if the time of GRU is 22° -->			
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlGRU" interface="gru"/>			
			<bind role="attNodeTest" component="readTextFromHtmlGRU" interface="gru">
				<bindParam name="value" value="22"/>				
			</bind>							
			<bind role="start" component="mImgSun"/>
			<bind role="start" component="mCityGRU"/>
			<bind role="start" component="mCelsius"/>							
		</link>
		
		<!-- Rule 6.1: Checking if the time of GRU is 15° -->
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlGRU" interface="gru"/>			
			<bind role="attNodeTest" component="readTextFromHtmlGRU" interface="gru">
				<bindParam name="value" value="15"/>				
			</bind>							
			<bind role="start" component="mImgCloud"/>
			<bind role="start" component="mCityGRU"/>
			<bind role="start" component="mCelsius"/>							
		</link>
		
		<!-- Rule 6.2: Checking if the time of GRU is 0° -->
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlGRU" interface="gru"/>			
			<bind role="attNodeTest" component="readTextFromHtmlGRU" interface="gru">
				<bindParam name="value" value="0"/>				
			</bind>							
			<bind role="start" component="mImgSnow"/>
			<bind role="start" component="mCityGRU"/>
			<bind role="start" component="mCelsius"/>							
		</link>
		
		<!-- Rule 6.3: Checking if the time of JPA is 22° -->				
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlJPA" interface="jpa"/>			
			<bind role="attNodeTest" component="readTextFromHtmlJPA" interface="jpa">
				<bindParam name="value" value="22"/>				
			</bind>							
			<bind role="start" component="mImgSun"/>
			<bind role="start" component="mCityJPA"/>
			<bind role="start" component="mCelsius"/>
		</link>
		
		<!-- Rule 6.4: Checking if the time of JPA is 15° -->	
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlJPA" interface="jpa"/>			
			<bind role="attNodeTest" component="readTextFromHtmlJPA" interface="jpa">
				<bindParam name="value" value="15"/>				
			</bind>							
			<bind role="start" component="mImgCloud"/>
			<bind role="start" component="mCityJPA"/>
			<bind role="start" component="mCelsius"/>
		</link>
		
		<!-- Rule 6.5: Checking if the time of JPA is 0° -->	
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlJPA" interface="jpa"/>			
			<bind role="attNodeTest" component="readTextFromHtmlJPA" interface="jpa">
				<bindParam name="value" value="0"/>				
			</bind>							
			<bind role="start" component="mImgSnow"/>
			<bind role="start" component="mCityJPA"/>
			<bind role="start" component="mCelsius"/>
		</link>
		
		<!-- Rule 6.6: Checking if the time of POA is 22° -->					
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlPOA" interface="poa"/>			
			<bind role="attNodeTest" component="readTextFromHtmlPOA" interface="poa">
				<bindParam name="value" value="22"/>				
			</bind>							
			<bind role="start" component="mImgSun"/>
			<bind role="start" component="mCityPOA"/>
			<bind role="start" component="mCelsius"/>
		</link>	
		
		<!-- Rule 6.7: Checking if the time of POA is 15° -->	
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlPOA" interface="poa"/>			
			<bind role="attNodeTest" component="readTextFromHtmlPOA" interface="poa">
				<bindParam name="value" value="15"/>				
			</bind>							
			<bind role="start" component="mImgCloud"/>
			<bind role="start" component="mCityPOA"/>
			<bind role="start" component="mCelsius"/>
		</link>	
		
		<!-- Rule 6.8: Checking if the time of POA is 0° -->
		<link xconnector="connector#onEndAttNodeTestStartN">
			<bind role="onEndAttribution" component="readTextFromHtmlPOA" interface="poa"/>			
			<bind role="attNodeTest" component="readTextFromHtmlPOA" interface="poa">
				<bindParam name="value" value="0"/>				
			</bind>							
			<bind role="start" component="mImgSnow"/>
			<bind role="start" component="mCityPOA"/>
			<bind role="start" component="mCelsius"/>
		</link>	
				
		<!-- Rule 7: If selected RED Key while temperature GRU is active, then return to icon of Interactivity. -->
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="mCityGRU">
				<bindParam name="keyCode" value="RED"/>
			</bind>			
			<bind role="stop" component="mCityGRU"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>
			<bind role="stop" component="mCelsius"/>
			<bind role="stop" component="readTextFromHtmlGRU"/>
			<bind role="stop" component="showTempGRU"/>
			<bind role="start" component="mInteractivity"/>			
		</link>
		
		<!-- Rule 7.1: If selected RED Key while temperature JPA is active, then return to icon of Interactivity. -->
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="mCityJPA">
				<bindParam name="keyCode" value="RED"/>
			</bind>			
			<bind role="stop" component="mCityJPA"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>
			<bind role="stop" component="mCelsius"/>
			<bind role="stop" component="readTextFromHtmlJPA"/>
			<bind role="stop" component="showTempJPA"/>
			<bind role="start" component="mInteractivity"/>			
		</link>
		
		<!-- Rule 7.2: If selected RED Key while temperature POA is active, then return to icon of Interactivity. -->
		<link xconnector="connector#onKeySelectionStartNStopN">
			<bind role="onSelection" component="mCityPOA">
				<bindParam name="keyCode" value="RED"/>
			</bind>			
			<bind role="stop" component="mCityPOA"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>
			<bind role="stop" component="mCelsius"/>
			<bind role="stop" component="readTextFromHtmlPOA"/>
			<bind role="stop" component="showTempPOA"/>
			<bind role="start" component="mInteractivity"/>			
		</link>		
		
		<!-- Rule 8: When the movie ends, finish all media. -->
		<link xconnector="connector#onEndStopN">
			<bind role="onEnd" component="mMovie" />
			<bind role="stop" component="mMenu"/>
			<bind role="stop" component="mInteractivity"/>
			<bind role="stop" component="mImgSun"/>
			<bind role="stop" component="mImgSnow"/>
			<bind role="stop" component="mImgCloud"/>
			<bind role="stop" component="mCityGRU"/>
			<bind role="stop" component="mCityJPA"/>
			<bind role="stop" component="mCityPOA"/>
			<bind role="stop" component="mCelsius"/>
			<bind role="stop" component="readTextFromHtmlGRU"/>
			<bind role="stop" component="readTextFromHtmlJPA"/>
			<bind role="stop" component="readTextFromHtmlPOA"/>
			<bind role="stop" component="showTempGRU"/>
			<bind role="stop" component="showTempJPA"/>
			<bind role="stop" component="showTempPOA"/>						
		</link>												
	</body>
</ncl>
