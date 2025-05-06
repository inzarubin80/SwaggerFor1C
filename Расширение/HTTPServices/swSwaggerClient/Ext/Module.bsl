
Функция SwagerGET(Запрос)
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.Заголовки.Вставить("Content-Type","text/html; charset=utf-8");
	HTMLSwaggerClient = ПолучитьОбщийМакет("swSwaggerClient").ПолучитьТекст();	
	HTMLSwaggerClient = СтрЗаменить(HTMLSwaggerClient, "#host", ПолучитьБазовыйURL(Запрос.БазовыйURL));  
	Ответ.Заголовки.Вставить("Content-Type","text/html; charset=utf-8");
	Ответ.УстановитьТелоИзСтроки(HTMLSwaggerClient, "UTF-8");   
	Возврат Ответ;

КонецФункции

Функция SwaggerJsonGET(Запрос)
	
	Ответ = Новый HTTPСервисОтвет(200);	
	ЧтениеJSON = Новый ЧтениеJSON;
	SwaggerJson = ПолучитьОбщийМакет("swSwaggerJson").ПолучитьТекст();
	БазовыйURL = ПолучитьБазовыйURL(Запрос.БазовыйURL);
	SwaggerJson = СтрЗаменить(SwaggerJson, "http://host/hs#",БазовыйURL);  
	Ответ.Заголовки.Вставить("Content-Type","application/json; charset=utf-8");
	Ответ.УстановитьТелоИзСтроки(SwaggerJson,"UTF-8");  	
	Возврат Ответ;

КонецФункции

Функция ПолучитьБазовыйURL(Знач БазовыйURL)
    
	Возврат Сред(БазовыйURL, 1, СтрНайти(БазовыйURL, "/hs/"))+"hs";
	
КонецФункции 