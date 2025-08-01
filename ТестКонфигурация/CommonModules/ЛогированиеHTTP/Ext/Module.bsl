﻿// Обрабатывает HTTP запрос, выполняет логирование при необходимости
//
// Параметры:
//   ИдентификаторОбработчика - Строка - идентификатор обработчика
//   HTTPЗапрос - HTTPСервисЗапрос - входящий HTTP запрос
//   ВыполняемыеОбработчики - Структура - цепочка обработчиков
//
// Возвращаемое значение:
//   HTTPСервисОтвет - результат обработки запроса
//
Функция Обработчик(HTTPЗапрос, ИдентификаторОбработчика,  КонтекстВыполнения) Экспорт
	
	
	ДатаСтарта = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
    HTTPОтвет = ОбработчикHTTP.ВыполнитьОбработчик( 
		HTTPЗапрос,
        ИдентификаторОбработчика,  
        КонтекстВыполнения
    );
     
    Если НужноЛогировать(ИдентификаторОбработчика, HTTPОтвет.КодСостояния) Тогда
        ЛогироватьВызов(
            ИдентификаторОбработчика,
            HTTPЗапрос,
            HTTPОтвет,
			ДатаСтарта
        );
    КонецЕсли;
    
    Возврат HTTPОтвет;
        
КонецФункции    

// Формирует JSON представление HTTP запроса
//
// Параметры:
//   HTTPЗапрос - HTTPСервисЗапрос - запрос
//
// Возвращаемое значение:
//   Строка - JSON представление запроса
//
Функция ПолучитьПредставлениеЗапроса(HTTPЗапрос)
    
    ДанныеЗапроса = Новый Структура;
    ДанныеЗапроса.Вставить("HTTPМетод", HTTPЗапрос.HTTPМетод);
    ДанныеЗапроса.Вставить("БазовыйURL", HTTPЗапрос.БазовыйURL);
    ДанныеЗапроса.Вставить("Заголовки", HTTPЗапрос.Заголовки);
    ДанныеЗапроса.Вставить("ОтносительныйURL", HTTPЗапрос.ОтносительныйURL);
    ДанныеЗапроса.Вставить("ПараметрыURL", HTTPЗапрос.ПараметрыURL);
    ДанныеЗапроса.Вставить("ПараметрыЗапроса", HTTPЗапрос.ПараметрыЗапроса);
    ДанныеЗапроса.Вставить("Тело", HTTPЗапрос.ПолучитьТелоКакСтроку());
    
    Возврат ПреобразоватьВJSON(ДанныеЗапроса);
    
КонецФункции 

// Формирует JSON представление HTTP ответа
//
// Параметры:
//   HTTPОтвет - HTTPСервисОтвет - ответ
//
// Возвращаемое значение:
//   Строка - JSON представление ответа
//
Функция ПолучитьПредставлениеОтвета(HTTPОтвет)
    
    ДанныеОтвета = Новый Структура;
    ДанныеОтвета.Вставить("Заголовки", HTTPОтвет.Заголовки);
    ДанныеОтвета.Вставить("Тело", HTTPОтвет.ПолучитьТелоКакСтроку());
    ДанныеОтвета.Вставить("КодСостояния", HTTPОтвет.КодСостояния);
    
    Возврат ПреобразоватьВJSON(ДанныеОтвета);
    
КонецФункции 

// Преобразует структуру в JSON строку
//
// Параметры:
//   Данные - Структура - данные для преобразования
//
// Возвращаемое значение:
//   Строка - JSON представление данных
//
Функция ПреобразоватьВJSON(Данные)
    
    ПисательJSON = Новый ЗаписьJSON;
    Параметры = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет);
    ПисательJSON.УстановитьСтроку(Параметры);
    
    ЗаписатьJSON(ПисательJSON, Данные);
    
    Возврат ПисательJSON.Закрыть();
    
КонецФункции

// Регистрирует вызов обработчика в журнале
//
// Параметры:
//   ИдентификаторОбработчика - Строка - идентификатор обработчика
//   HTTPЗапрос - HTTPСервисЗапрос - запрос
//   HTTPОтвет - HTTPСервисОтвет - ответ
//
Процедура ЛогироватьВызов(ИдентификаторОбработчика, HTTPЗапрос, HTTPОтвет, ДатаСтарта)
    
    ЗаписьЖурнала = РегистрыСведений.ЖурналHTTPЗапросов.СоздатьМенеджерЗаписи();
    ЗаписьЖурнала.ИдентификаторОбработчика = ИдентификаторОбработчика;
    ЗаписьЖурнала.ДатаРегистрации = ТекущаяУниверсальнаяДатаВМиллисекундах();
    ЗаписьЖурнала.ПредставлениеЗапроса = ПолучитьПредставлениеЗапроса(HTTPЗапрос);
    ЗаписьЖурнала.ПредставлениеОтвета = ПолучитьПредставлениеОтвета(HTTPОтвет);
    ЗаписьЖурнала.КодОтвета = HTTPОтвет.КодСостояния; 
	ЗаписьЖурнала.Длительность = ТекущаяУниверсальнаяДатаВМиллисекундах() - ДатаСтарта; 
	ЗаписьЖурнала.Записать();
    
КонецПроцедуры

// Проверяет, нужно ли логировать вызов обработчика
//
// Параметры:
//   ИдентификаторОбработчика - Строка - идентификатор обработчика
//   КодСостояния - Число - HTTP код состояния
//
// Возвращаемое значение:
//   Булево - нужно ли логировать
//
Функция НужноЛогировать(ИдентификаторОбработчика, КодСостояния)
    
    Если КодСостояния = 500 Тогда
        Возврат Истина;
    КонецЕсли;
        
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ ПЕРВЫЕ 1
    |	НастройкиЛогированияHTTP.ИдентификаторОбработчика КАК Обработчик
    |ИЗ
    |	РегистрСведений.НастройкиЛогированияHTTP КАК НастройкиЛогированияHTTP
    |ГДЕ
    |	НастройкиЛогированияHTTP.ИдентификаторОбработчика = &ИдентификаторОбработчика
    |	И (НастройкиЛогированияHTTP.КодСостояния = 0
    |			ИЛИ НастройкиЛогированияHTTP.КодСостояния = &КодСостояния)";
    
    Запрос.УстановитьПараметр("ИдентификаторОбработчика", ИдентификаторОбработчика);
    Запрос.УстановитьПараметр("КодСостояния", КодСостояния);
        
    Возврат НЕ Запрос.Выполнить().Пустой();
    
КонецФункции