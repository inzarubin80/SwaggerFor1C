﻿// Возвращает HTTP ответ после выполнения цепочки обработчиков
//
// Параметры:
//   ИдентификаторОбработчика - Строка - идентификатор обработчика
//   Запрос - HTTPСервисЗапрос - входящий HTTP запрос
//   КонечныйОбработчикЗапроса - Строка - имя метода конечного обработчика
//
// Возвращаемое значение:
//   HTTPСервисОтвет - результат обработки запроса
//
Функция ПолучитьОтвет(Запрос, ИдентификаторОбработчика, КонечныйОбработчикЗапроса) Экспорт 
    
    ВыполняемыеОбработчики = Новый Массив;
    ВыполняемыеОбработчики.Добавить("ЛогированиеHTTP.Обработчик");
    ВыполняемыеОбработчики.Добавить(КонечныйОбработчикЗапроса);

    КонтекстВыполнения = Новый Структура("ТекущийОбработчик, ВыполняемыеОбработчики", 0, ВыполняемыеОбработчики);
    
    Возврат ВыполнитьОбработчик(Запрос, ИдентификаторОбработчика, КонтекстВыполнения);
    
КонецФункции    

// Возвращает список поддерживаемых идентификаторов обработчиков
//
// Возвращаемое значение:
//   Массив - список строковых идентификаторов обработчиков
//
Функция ПолучитьИдентификаторыОбработчиков() Экспорт
    
    Обработчики = Новый Массив;
    Обработчики.Добавить("GET mdm/products");
    Обработчики.Добавить("POST mdm/products");
    
    Возврат Обработчики;
    
КонецФункции 

// Выполняет обработчик HTTP запроса по цепочке
//
// Параметры:
//   ИдентификаторОбработчика - Строка - идентификатор обработчика
//   Запрос - HTTPСервисЗапрос - входящий HTTP запрос
//   КонтекстВыполнения - Структура - контекст выполнения цепочки обработчиков
//
// Возвращаемое значение:
//   HTTPСервисОтвет - результат обработки
//
Функция ВыполнитьОбработчик(HTTPЗапрос, ИдентификаторОбработчика,  КонтекстВыполнения) Экспорт
    
    HTTPОтвет = Неопределено;
    ИндексОбработчика = КонтекстВыполнения.ТекущийОбработчик;
    Обработчики = КонтекстВыполнения.ВыполняемыеОбработчики;
    ИмяОбработчика = Обработчики[ИндексОбработчика];
    
   Попытка
        Если ИндексОбработчика = Обработчики.ВГраница() Тогда
			Выполнить("HTTPОтвет = " + ИмяОбработчика + "(HTTPЗапрос, ИдентификаторОбработчика)"); 
		Иначе
            КонтекстВыполнения.ТекущийОбработчик = ИндексОбработчика + 1;  
			Выполнить("HTTPОтвет = " + ИмяОбработчика + "(HTTPЗапрос, ИдентификаторОбработчика, КонтекстВыполнения)");  			
        КонецЕсли;
    Исключение
        HTTPОтвет = СоздатьОтветСОшибкой(500, ОписаниеОшибки());
    КонецПопытки;
    
    Возврат HTTPОтвет;
    
КонецФункции

// Создает HTTP ответ с ошибкой
//
// Параметры:
//   КодОшибки - Число - HTTP код ошибки
//   Сообщение - Строка - текст ошибки
//
// Возвращаемое значение:
//   HTTPСервисОтвет - ответ с ошибкой
//
Функция СоздатьОтветСОшибкой(КодОшибки, Сообщение)
    
    HTTPОтвет = Новый HTTPСервисОтвет(КодОшибки);
	HTTPОтвет.Заголовки.Вставить("Content-Type","text/text; charset=UTF-8");
	HTTPОтвет.УстановитьТелоИзСтроки(Сообщение);
    Возврат HTTPОтвет;
    
КонецФункции