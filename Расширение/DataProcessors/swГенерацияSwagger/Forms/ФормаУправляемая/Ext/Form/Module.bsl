﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
		
	ОбъектОбработки = РеквизитФормыВЗначение("Объект"); 

	СведенияОВнешнейОбработке = ОбъектОбработки.СведенияОВнешнейОбработке();

	Заголовок = СтрШаблон("%1 %2 (%3)", ОбъектОбработки.Метаданные().Синоним, СведенияОВнешнейОбработке.Версия, СведенияОВнешнейОбработке.ДатаВыпуска);
	
	СформироватьСписокСервисов(); 
	СформироватьСписокМетодов();
	
	ПоддерживаемыеТипыSwagger  = ОбъектОбработки.ПоддерживаемыеТипыSwagger;	
	Локации = ОбъектОбработки.Локации;
	ИменаНотаций = ОбъектОбработки.ИменаНотаций;
	
	ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ПараметрыЗапросаЛокация.СписокВыбора, Локации); 
	ЗаполнитьСписокВыбораЭлементаФормы(Элементы.ПараметрыЗапросаТип.СписокВыбора, ПоддерживаемыеТипыSwagger); 
	ЗаполнитьСписокВыбораЭлементаФормы(Элементы.РезультатыЗапросаТип.СписокВыбора, ПоддерживаемыеТипыSwagger);   
	
	
	Элементы.ПараметрыЗаголовкаРезультатаОтветаТип.СписокВыбора.Добавить(ПоддерживаемыеТипыSwagger.number);
	Элементы.ПараметрыЗаголовкаРезультатаОтветаТип.СписокВыбора.Добавить(ПоддерживаемыеТипыSwagger.string);
	
	Элементы.РезультатыЗапросКодОтвета.СписокВыбора.ЗагрузитьЗначения(ПолучитьКодыОтветов());
	Элементы.ПараметрыЗаголовкаРезультатаОтветаКодОтвета.СписокВыбора.ЗагрузитьЗначения(ПолучитьКодыОтветов());
	
	ИзменитьПолеСохранения();
	
	Объект.КаталогПроекта1с = "";
	Объект.SwaggerJson = "";
	Объект.HTMLSwaggerКлиент = "";
	
	ПриСозданииНаСервереMonacoEditor(Отказ, СтандартнаяОбработка);
КонецПроцедуры 

 &НаСервере
Процедура ПриСохраненииДанныхВНастройкахНаСервере(Настройки)
	
	знОбъект = РеквизитФормыВЗначение("Объект");
	Для Каждого мтдТч ИЗ знОбъект.Метаданные().ТабличныеЧасти Цикл
		Настройки.Вставить(мтдТч.Имя,Объект[мтдТч.Имя].Выгрузить());
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	знОбъект = РеквизитФормыВЗначение("Объект");
	
	Для Каждого мтдТч ИЗ знОбъект.Метаданные().ТабличныеЧасти Цикл
		
		знОбъект = РеквизитФормыВЗначение("Объект");
		Попытка
			Объект[мтдТч.Имя].Загрузить(Настройки.Получить(мтдТч.Имя));
		Исключение
		КонецПопытки 
	КонецЦикла;
	
	СформироватьСписокМетодов();
	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура МетодПриИзменении(Элемент)
	
	СформироватьНотации();
	
КонецПроцедуры 

&НаКлиенте
Процедура РезультатыЗапросаКомментарийОкноПриИзменении(Элемент)
	
	СформироватьНотации();
	
КонецПроцедуры

&НаКлиенте
Процедура СервисПриИзменении(Элемент)
	
	Объект.Метод = "";
	СформироватьСписокМетодов();
	
	СформироватьНотации();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПараметрыЗапроса

&НаКлиенте
Процедура ПараметрыЗапросаПриИзменении(Элемент)
		
	СформироватьНотации();
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыЗапросаЗначениеПриИзменении(Элемент)
	
	СформироватьНотации();
	
КонецПроцедуры  

&НаКлиенте
Процедура ПараметрыЗапросаЛокацияПриИзменении(Элемент)
	
	 ТекущиеДанные = Элементы.ПараметрыЗапроса.ТекущиеДанные;
	 Если ТекущиеДанные.Имя="" И ТекущиеДанные.Локация = Локации.body  Тогда
		 ТекущиеДанные.Имя = "requestBody";
	 КонецЕсли;
	 СформироватьНотации();
	 
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыЗапросаПослеУдаления(Элемент)

	СформироватьНотации();
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыЗапросаЗначениеСтрокаОткрытие(ПолеФормы, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;  
	ТекущиеДанные = Элементы.ПараметрыЗапроса.ТекущиеДанные;
	ОткрытьФормуРедактированияJSON(ТекущиеДанные.Значение, "Значение", "ПараметрыЗапроса", ТекущиеДанные.Номерстроки);
	
КонецПроцедуры 

#КонецОбласти     

#Область ОбработчикиСобытийЭлементовТаблицыФормыРезультатыЗапроса

&НаКлиенте
Процедура РезультатыЗапросаПриИзменении(Элемент)
	
	ИзменитьПолеСохранения();
	СформироватьНотации(); 
	
КонецПроцедуры   

&НаКлиенте
Процедура РезультатыЗапросЗначениеПриИзменении(Элемент)
	
	СформироватьНотации();  
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатыЗапросаПослеУдаления(Элемент)
	СформироватьНотации();
КонецПроцедуры

&НаКлиенте
Процедура РезультатыЗапросЗначениеСтрокаОткрытие(Элемент, СтандартнаяОбработка)

    СтандартнаяОбработка = Ложь;  
	ТекущиеДанные = Элементы.РезультатыЗапроса.ТекущиеДанные;
	ОткрытьФормуРедактированияJSON(ТекущиеДанные.Значение, "Значение", "РезультатыЗапроса", ТекущиеДанные.Номерстроки);

КонецПроцедуры

#КонецОбласти     

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьНотации(Команда)
	
	СформироватьНотации();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьНотации()
	
	ИзменитьПолеСохранения();
	
	Объект.Нотации = "";  
	
	ОшибкиЗаполнения = ПроверитьЗаполнениеДляФормированияНотаций();
	Если ОшибкиЗаполнения.Количество() Тогда
		ОшибкиЗаполнения.Вставить(0, "Обнаружены ошибки");
		Объект.Нотации = СтрСоединить(ОшибкиЗаполнения, Символы.ПС);   
		Объект.ОшибкаФормированияНотаций = Истина;
		Возврат;
	КонецЕсли;                                   
	
	Объект.ОшибкаФормированияНотаций = Ложь;
	
	ОписаниеТипов = Новый Массив;
	
	Имена = СтрРазделить(Объект.Метод,"@");
	ИмяШаблона = Имена[0];
	ИмяМетода = Имена[1];
	мтдСервис = Метаданные.HTTPСервисы[Объект.Сервис];
	мтдШаблон = мтдСервис.ШаблоныURL[ИмяШаблона];
	мтдМетод  = мтдШаблон.Методы[ИмяМетода];  
	
	МассивНотаций = Новый Массив;
	МассивНотаций.Добавить(СтрШаблон("@Tags		%1",  мтдСервис.Имя)); 
	
	НаименованиеСервиса = СтрШаблон("%1 (%2 %3)", мтдСервис.Синоним, мтдШаблон.Синоним, Строка(мтдМетод.HTTPМетод));
	КомментарийСервиса = ?(ЗначениеЗаполнено(мтдМетод.Комментарий), мтдМетод.Комментарий, НаименованиеСервиса);
	
	МассивНотаций.Добавить(СтрШаблон("@Summary		%1", НаименованиеСервиса));
	МассивНотаций.Добавить(СтрШаблон("@Description		%1", КомментарийСервиса));
	МассивНотаций.Добавить(СтрШаблон("@Router	/%1%2 [%3]", мтдСервис.КорневойURL, мтдШаблон.Шаблон, Строка(мтдМетод.HTTPМетод)));
	МассивНотаций.Добавить("@Produce json");
	МассивНотаций.Добавить("@Accept	json");    
	
	Для Каждого СтрокаТЧ ИЗ Объект.ПараметрыЗапроса Цикл		
		
		МассивСтрокиПараметр = Новый Массив;        
		МассивСтрокиПараметр.Добавить("@Param");		
		МассивСтрокиПараметр.Добавить(СтрокаТЧ.Имя);
		МассивСтрокиПараметр.Добавить(СтрокаТЧ.Локация);
		МассивСтрокиПараметр.Добавить(СтрокаТЧ.Тип);
		МассивСтрокиПараметр.Добавить(Формат(СтрокаТЧ.Обязательный, "БЛ=false; БИ=true"));
		МассивСтрокиПараметр.Добавить(СтрШаблон("""%1""", СтрокаТЧ.Комментарий));
		МассивНотаций.Добавить(СтрСоединить(МассивСтрокиПараметр,Символы.Таб + Символы.Таб));
		МассивНотаций.Добавить("<value>");       
		МассивНотаций.Добавить(СтрокаТЧ.Значение);
		МассивНотаций.Добавить("</value>");

	КонецЦикла;  
	
	
	Для Каждого СтрокаТЧ ИЗ Объект.РезультатыЗапроса Цикл		
		
		МассивСтрокиРезультат = Новый Массив;        
		МассивСтрокиРезультат.Добавить("@" + ПолучитьВариантОтвета(СтрокаТЧ.КодОтвета));		
		МассивСтрокиРезультат.Добавить(СтрокаТЧ.КодОтвета);
		МассивСтрокиРезультат.Добавить(СтрШаблон("{%1}	%1", СтрокаТЧ.Тип));
		МассивСтрокиРезультат.Добавить(СтрШаблон("""%1""", СтрокаТЧ.Комментарий));
		МассивНотаций.Добавить(СтрСоединить(МассивСтрокиРезультат,Символы.Таб + Символы.Таб));
		МассивНотаций.Добавить("<value>");
		МассивНотаций.Добавить(СтрокаТЧ.Значение);
		МассивНотаций.Добавить("</value>");
		
	КонецЦикла;        
	
	
	Для Каждого СтрокаТЧ ИЗ Объект.ПараметрыЗаголовкаРезультатаОтвета Цикл		
		
		МассивПараметрыЗаголовкаРезультатаОтвета = Новый Массив;        
		МассивПараметрыЗаголовкаРезультатаОтвета.Добавить("@Header");		
		МассивПараметрыЗаголовкаРезультатаОтвета.Добавить(СтрокаТЧ.КодОтвета);
		МассивПараметрыЗаголовкаРезультатаОтвета.Добавить(СтрШаблон("{%1}", СтрокаТЧ.Тип));  
		МассивПараметрыЗаголовкаРезультатаОтвета.Добавить(СтрокаТЧ.Имя);  		
		МассивПараметрыЗаголовкаРезультатаОтвета.Добавить(СтрШаблон("""%1""", СтрокаТЧ.Комментарий));
		МассивНотаций.Добавить(СтрСоединить(МассивПараметрыЗаголовкаРезультатаОтвета,Символы.Таб + Символы.Таб));
		МассивНотаций.Добавить("<value>");
		МассивНотаций.Добавить(СтрокаТЧ.Значение);
		МассивНотаций.Добавить("</value>");
		
	КонецЦикла;  

	
	Объект.Нотации =  ДобавитьКомментрии(СтрСоединить(МассивНотаций, Символы.ПС));
	
КонецПроцедуры 

&НаСервере
Процедура ЗаполнитьСписокВыбораЭлементаФормы(СписокВыбора, Источник) 
	
	СписокВыбора.Очистить();
	Для Каждого Элемент ИЗ Источник Цикл
		СписокВыбора.Добавить(Элемент.Ключ);   
	КонецЦикла;
	
КонецПроцедуры 

&НаСервере
Процедура СформироватьСписокСервисов()
	
	Элементы.Сервис.СписокВыбора.Очистить();
	Для Каждого мтдСервис ИЗ 	Метаданные.HTTPСервисы Цикл
		Элементы.Сервис.СписокВыбора.Добавить(мтдСервис.Имя, мтдСервис.Синоним);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СформироватьСписокМетодов()
	
	Элементы.Метод.СписокВыбора.Очистить();
	Если ЗначениеЗаполнено(Объект.Сервис) Тогда
		мтдСервис = Метаданные.HTTPСервисы[Объект.Сервис];
		Для Каждого мтдШаблон ИЗ мтдСервис.ШаблоныURL Цикл 
			Для Каждого мтдМетод ИЗ  мтдШаблон.Методы Цикл
				Элементы.Метод.СписокВыбора.Добавить(мтдШаблон.Имя +"@"+  мтдМетод.Имя, мтдШаблон.Шаблон + " " +  Строка(мтдМетод.HTTPМетод));
			КонецЦикла;			
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры 

&НаСервере
Процедура ИзменитьПолеСохранения()
	
	Объект.ПолеСохранения = НЕ Объект.ПолеСохранения;
	
КонецПроцедуры 

Функция ПроверитьЗаполнениеДляФормированияНотаций()
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
		
	ОшибкиДанных = Новый Массив;
	
	ПоляПроверкиЗаполнения = Новый Массив;
	ПоляПроверкиЗаполнения.Добавить("Сервис");
	ПоляПроверкиЗаполнения.Добавить("Метод");
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗапроса.Локация");
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗапроса.Имя");
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗапроса.Комментарий"); 
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗапроса.Значение"); 
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗапроса.Тип"); 	
	
	ПоляПроверкиЗаполнения.Добавить("РезультатыЗапроса.КодОтвета"); 
	ПоляПроверкиЗаполнения.Добавить("РезультатыЗапроса.Значение"); 
	ПоляПроверкиЗаполнения.Добавить("РезультатыЗапроса.Комментарий"); 
	ПоляПроверкиЗаполнения.Добавить("РезультатыЗапроса.Тип"); 

	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗаголовкаРезультатаОтвета.КодОтвета"); 
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗаголовкаРезультатаОтвета.Значение"); 
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗаголовкаРезультатаОтвета.Комментарий"); 
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗаголовкаРезультатаОтвета.Тип");
	ПоляПроверкиЗаполнения.Добавить("ПараметрыЗаголовкаРезультатаОтвета.Имя");
	
	ПоляПроверкиЗаполненияПоОбъектам =  Новый Соответствие;
	
	Для Каждого Поле ИЗ ПоляПроверкиЗаполнения Цикл
		
		Массив = СтрРазделить(Поле, ".");
		ИмяПоля = Массив[0];
		ИмяТЧ = "";
		Если Массив.Количество()>1 Тогда
			ИмяТЧ 	= Массив[0]; 
			ИмяПоля = Массив[1];
		Иначе
			ИмяПоля = Массив[0];
			ИмяТЧ = "";
		КонецЕсли; 
		МассивПолей = ПоляПроверкиЗаполненияПоОбъектам.Получить(ИмяТЧ);
		Если МассивПолей = Неопределено Тогда
			МассивПолей = Новый Массив;
		КонецЕсли;  
		МассивПолей.Добавить(ИмяПоля);
		ПоляПроверкиЗаполненияПоОбъектам.Вставить(ИмяТЧ, МассивПолей);
		
	КонецЦикла;
	
	Для Каждого Элемент ИЗ  ПоляПроверкиЗаполненияПоОбъектам Цикл
		
		Если Элемент.Ключ<>"" Тогда
			ТабличнаяЧасть = Объект[Элемент.Ключ]
		КонецЕсли;
		
		Для Каждого Поле ИЗ  Элемент.Значение Цикл
			Если Элемент.Ключ="" Тогда
				ПроверяемоеЗначание = Объект[Поле];
				Если Не ЗначениеЗаполнено(ПроверяемоеЗначание) Тогда
					ОшибкиДанных.Добавить(СтрШаблон("Не заполнено значение поля ""%1""",Поле ));	
				КонецЕсли;					
			Иначе
				Для Каждого СтрокаТЧ ИЗ ТабличнаяЧасть Цикл	
					
					Если СтрокаТЧ.Тип = ПоддерживаемыеТипыSwagger.string  и Поле = "Значение" Тогда
						Продолжить;
					КонецЕсли;
					
					ПроверяемоеЗначание = СтрокаТЧ[Поле];
					Если Не ЗначениеЗаполнено(ПроверяемоеЗначание) Тогда
						ОшибкиДанных.Добавить(СтрШаблон("В строке ""%1"" табличной части ""%2"" не заполнено значение поля ""%3"" ",СтрокаТЧ.НомерСтроки, Элемент.Ключ,  Поле));	
					КонецЕсли;					
					
				КонецЦИкла;
			КонецЕсли;                                 
		КонецЦикла;
	КонецЦикла;   
	
	Если ОшибкиДанных.Количество() Тогда
		Возврат ОшибкиДанных;
	КонецЕсли;
	
	Имена = СтрРазделить(Объект.Метод,"@");
	ИмяШаблона = Имена[0];
	ИмяМетода = Имена[1];
	мтдСервис = Метаданные.HTTPСервисы[Объект.Сервис];
	мтдШаблон = мтдСервис.ШаблоныURL[ИмяШаблона];
	мтдМетод  = мтдШаблон.Методы[ИмяМетода]; 
	
	КоличествоBody = 0;
	Для Каждого СтрокаТЧ ИЗ Объект.ПараметрыЗапроса Цикл
		
		Если СтрокаТЧ.Локация = Локации.body  Тогда
			КоличествоBody = КоличествоBody  + 1;	
		КонецЕсли;     
		
		Если СтрокаТЧ.Локация = Локации.query ИЛИ СтрокаТЧ.Локация = Локации.header Тогда 
			Если  НЕ (СтрокаТЧ.Тип = ПоддерживаемыеТипыSwagger.string ИЛИ СтрокаТЧ.Тип = ПоддерживаемыеТипыSwagger.number ИЛИ СтрокаТЧ.Тип = ПоддерживаемыеТипыSwagger.boolean) Тогда
				ОшибкиДанных.Добавить(СтрШаблон("В строке ""%1"" табличной части ""%2""  тип ""%3""  не соответствует указанной локации ""%4"" (допустимо число, строка, булево)",СтрокаТЧ.НомерСтроки, "Параметры запроса", СтрокаТЧ.Тип, СтрокаТЧ.Локация));		
			КонецЕсли;
		КонецЕсли;
		
		
		Если СтрокаТЧ.Локация = Локации.path Тогда
			Если СтрНайти(мтдШаблон.Шаблон,СтрШаблон("%1", СтрокаТЧ.Имя))=0 Тогда
				ОшибкиДанных.Добавить(СтрШаблон("В строке ""%1"" табличной части ""%2""  параметр ""{%3}"" (типа path) не найдент в шаблоне ""%4""",СтрокаТЧ.НомерСтроки, "Параметры запроса", СтрокаТЧ.Имя, мтдШаблон.Шаблон));					
			КонецЕсли;			
		КонецЕсли;
		
		ПроверитьТип(ОшибкиДанных, СтрокаТЧ, "Параметры запроса");
		ПроверитьSchemaSwagger(ОбработкаОбъект, ОшибкиДанных, СтрокаТЧ, "Параметры запроса");
		
	КонецЦикла;   
	
	
	Если  КоличествоBody>1 Тогда
		ОшибкиДанных.Добавить(СтрШаблон("Может быть только один параметр in body"));	    
	ИначеЕсли КоличествоBody>0 И  мтдМетод.HTTPМетод =Метаданные.СвойстваОбъектов.HTTPМетод.GET  Тогда
		ОшибкиДанных.Добавить(СтрШаблон("В GET запросе не может быть тела"));
	КонецЕсли;   
	
	Если  НЕ Объект.РезультатыЗапроса.Количество() Тогда
		ОшибкиДанных.Добавить(СтрШаблон("Не заполнена табличная часть ""Результаты запроса"""));
	КонецЕсли;
	
	Для Каждого СтрокаТЧ ИЗ Объект.РезультатыЗапроса Цикл
		ПроверитьТип(ОшибкиДанных, СтрокаТЧ, "Результаты запроса");
		ПроверитьSchemaSwagger(ОбработкаОбъект, ОшибкиДанных, СтрокаТЧ, "Результаты запроса");
	КонецЦикла;
	ПроверитьДублированиеКодовОтвета(ОшибкиДанных);
	
	Для Каждого СтрокаТЧ ИЗ Объект.ПараметрыЗаголовкаРезультатаОтвета Цикл
		
		ПроверитьТип(ОшибкиДанных, СтрокаТЧ, "Параметры заголовка результата ответа");
		ПроверитьSchemaSwagger(ОбработкаОбъект, ОшибкиДанных, СтрокаТЧ, "Параметры заголовка результата ответа"); 
		
		Если 	НЕ Объект.РезультатыЗапроса.НайтиСтроки(Новый Структура("КодОтвета", СтрокаТЧ.КодОтвета)).Количество() Тогда
			ОшибкиДанных.Добавить(СтрШаблон("В строке ""%1"" табличной части ""%2""  код ответа ""%3""  не найден в табличной части ""Результаты запроса""",
			СтрокаТЧ.НомерСтроки, 
			"Параметры заголовка результата ответа", 
			СтрокаТЧ.КодОтвета));			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ОшибкиДанных;
	
КонецФункции 

Процедура ПроверитьSchemaSwagger(ОбработкаОбъект, ОшибкиДанных, СтрокаТЧ, ИмяТЧ)
	
	ЗначениеПараметра = ПолучитьЗначениеСтроки(СтрокаТЧ.Значение, СтрокаТЧ.Тип);
	Попытка 
		ОбработкаОбъект.ПолучитьSchemaSwagger(ЗначениеПараметра);	
	Исключение
		ОшибкиДанных.Добавить(СтрШаблон("В строке ""%1"" табличной части ""%2"" не удалось получить схему Swagger из значения ""%3"" ",СтрокаТЧ.НомерСтроки, ИмяТЧ, СтрокаТЧ.Значение));	
	КонецПопытки;
	
КонецПроцедуры  

Процедура ПроверитьТип(ОшибкиДанных, СтрокаТЧ, ИмяТЧ)
	
	ЗначениеПараметра = ПолучитьЗначениеСтроки(СтрокаТЧ.Значение, СтрокаТЧ.Тип);
	Тип = ПолучитьТипSwaggerПоЗначению(ЗначениеПараметра);
	Если Тип <> СтрокаТЧ.Тип Тогда
		ОшибкиДанных.Добавить(СтрШаблон("В строке ""%1"" табличной части ""%2""  тип ""%3""  не соответствует указанному значению ""%4""",СтрокаТЧ.НомерСтроки, ИмяТЧ, СтрокаТЧ.Тип, СтрокаТЧ.Значение));		
	КонецЕсли;
	
КонецПроцедуры 

Процедура ПроверитьДублированиеКодовОтвета(ОшибкиДанных)
	
	тзКодыОтветов = Объект.РезультатыЗапроса.Выгрузить(,"КодОтвета"); 
	тзКодыОтветов.Колонки.Добавить("Количество", Новый ОписаниеТипов("Число")); 
	тзКодыОтветов.ЗаполнитьЗначения(1, "Количество");
	тзКодыОтветов.Свернуть("КодОтвета", "Количество"); 
	Для Каждого СтрокаТаблицы ИЗ тзКодыОтветов Цикл
		Если СтрокаТаблицы.Количество > 1 Тогда
			ОшибкиДанных.Добавить(СтрШаблон("В табличной части ""Результаты запроса"" дублируется код ответа ""%1""", СтрокаТаблицы.КодОтвета));	
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры 

Функция ДобавитьКомментрии(ИсходнаяСтрока)
	
	МассивИсходныхСтрок = СтрРазделить(ИсходнаяСтрока, Символы.ПС);
	МассивНовыхСтрок = Новый Массив;
	Для  Каждого Строка ИЗ МассивИсходныхСтрок Цикл
		МассивНовыхСтрок.Добавить(СтрШаблон("// %1", Строка))
	КонецЦикла;
	Возврат СтрСоединить(МассивНовыхСтрок, Символы.ПС);
	
КонецФункции

Функция ПолучитьЗначениеСтроки(Знач ЗначениеСтрокой, ТипSwagger="") 
	
	Если ТипSwagger = ПоддерживаемыеТипыSwagger.String Тогда
		Возврат ЗначениеСтрокой;
	КонецЕсли;
	
	ЗначениеСтрокой = СокрЛП(ЗначениеСтрокой);
	Попытка
		Возврат  РеквизитФормыВЗначение("Объект").ПолучитьДанныеjson(ЗначениеСтрокой);
	Исключение
		Возврат   ЗначениеСтрокой;
	КонецПопытки;
	
КонецФункции 

Функция ПолучитьКодыОтветов()
	
	Результат = Новый Массив();
	Результат.Добавить(100);    
	Результат.Добавить(101); 
	Результат.Добавить(200); 
	Результат.Добавить(201); 
	Результат.Добавить(202); 
	Результат.Добавить(204); 
	Результат.Добавить(202); 
	Результат.Добавить(302);
	Результат.Добавить(304);
	Результат.Добавить(400);
	Результат.Добавить(401);
	Результат.Добавить(403);
	Результат.Добавить(404);
	Результат.Добавить(405);
	Результат.Добавить(408);
	Результат.Добавить(415);  
	Результат.Добавить(500);
	Результат.Добавить(501);
	Результат.Добавить(502);
	Результат.Добавить(503);
	Результат.Добавить(504);
	Возврат  Результат;
	
КонецФункции

Функция ПолучитьТипSwaggerПоЗначению(Значение1с)
	
	СоответсвиеТипов = Новый Соответствие;
	СоответсвиеТипов.Вставить(Тип("Число"), ПоддерживаемыеТипыSwagger.number);
	СоответсвиеТипов.Вставить(Тип("Булево"), ПоддерживаемыеТипыSwagger.boolean);
	СоответсвиеТипов.Вставить(Тип("Структура"), ПоддерживаемыеТипыSwagger.object);   
	СоответсвиеТипов.Вставить(Тип("Массив"), ПоддерживаемыеТипыSwagger.array);   
	СоответсвиеТипов.Вставить(Тип("Строка"), ПоддерживаемыеТипыSwagger.string);  
	СоответсвиеТипов.Вставить(Тип("Дата"), ПоддерживаемыеТипыSwagger.string);  
	
	ТипGO = СоответсвиеТипов.Получить(ТипЗнч(Значение1с));	 
		
	Возврат ТипGO;
	
КонецФункции 

Функция ПолучитьВариантОтвета(КодОтвета)
	
	Если "2" = Лев(Строка(КодОтвета), 1) Тогда
		Возврат "Success";
	Иначе
		Возврат "Failure";
	КонецЕсли;
	
КонецФункции 

&НаКлиенте
Процедура ОткрытьНастройкиПодключения(Команда)
	
	ОбработчикОткрытьНастройкиПодключения();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОткрытьНастройкиПодключения()
	
	ОткрытьФорму("ВнешняяОбработка.озГенерацияSwagger.Форма.ФормаНастройкиПодключения", Новый Структура("Логин, Пароль, АдресПубликации, АутенфикацияОС", Объект.Логин, Объект.Пароль, Объект.АдресПубликации, Объект.АутенфикацияОС)); 

КонецПроцедуры 

&НаКлиенте
Процедура ВыполнитьЗапрос(Команда)
	
	Если Не ЗначениеЗаполнено(Объект.Метод) Тогда
		Сообщить("Не заполнено значение поля ""Метод""");
		Возврат;
	КонецЕсли;

	РезультатЗапроса = ВыполнитьЗапросНаСервере();

	Если РезультатЗапроса.КодСостояния = Неопределено ИЛИ РезультатЗапроса.КодСостояния = 401 Тогда
		ОбработчикОткрытьНастройкиПодключения();
	Иначе
		ОткрытьФорму("ВнешняяОбработка.озГенерацияSwagger.Форма.ФормаРезультатЗапроса", РезультатЗапроса); 
	КонецЕсли;  
		
КонецПроцедуры

&НаСервере
Функция ВыполнитьЗапросНаСервере()
		
	Имена = СтрРазделить(Объект.Метод,"@");
	ИмяШаблона = Имена[0];
	ИмяМетода = Имена[1];
	мтдСервис = Метаданные.HTTPСервисы[Объект.Сервис];
	мтдШаблон = мтдСервис.ШаблоныURL[ИмяШаблона];
	мтдМетод  = мтдШаблон.Методы[ИмяМетода];  
	Шаблон = мтдШаблон.Шаблон;
	ТелоЗапроса = "";
	СтрокаПараметров = "";
	Заголовки = Новый Соответствие();
	
	Для каждого СтрокаТЧ  ИЗ Объект.ПараметрыЗапроса Цикл
		Если СтрокаТЧ.Локация = Локации.body Тогда
			ТелоЗапроса = СтрокаТЧ.Значение; 
		ИначеЕсли СтрокаТЧ.Локация = Локации.query Тогда
			Если СтрокаПараметров = "" Тогда
				СтрокаПараметров = СтрокаПараметров+"?";
			Иначе
				СтрокаПараметров = СтрокаПараметров+"&";
			КонецЕсли;
			СтрокаПараметров = СтрокаПараметров + СтрокаТЧ.Имя + "=" + СтрокаТЧ.Значение; 
		ИначеЕсли  СтрокаТЧ.Локация = Локации.header Тогда
			Заголовки.Вставить(СтрокаТЧ.Имя, СтрокаТЧ.Значение); 
		ИначеЕсли  СтрокаТЧ.Локация = Локации.path Тогда 
			Шаблон =  СтрЗаменить(Шаблон,"{" + СтрокаТЧ.Имя + "}",СтрокаТЧ.Значение);
		КонецЕсли;
	КонецЦикла;
	
	АдресРесурса = СтрШаблон("/hs/%1%2%3", мтдСервис.КорневойURL, Шаблон, СтрокаПараметров);
		
	HTTPЗапрос = Новый HTTPЗапрос(АдресРесурса, Заголовки);
	HTTPЗапрос.УстановитьТелоИзСтроки(ТелоЗапроса);	
	
	SSL_Соединение = Новый ЗащищенноеСоединениеOpenSSL(Новый СертификатКлиентаWindows(), Новый СертификатыУдостоверяющихЦентровWindows());
	Соединение = Новый HTTPСоединение(Объект.АдресПубликации,,Объект.Логин, Объект.Пароль,,, SSL_Соединение, Объект.АутенфикацияОС);
	
	Результат =Новый Структура;
	Результат.Вставить("КодСостояния", Неопределено);
	Результат.Вставить("ТелоОтвета",		Неопределено);
	Результат.Вставить("Заголовки",		Неопределено);

	Попытка

		HTTPОтвет = Соединение.ВызватьHTTPМетод(Строка(мтдМетод.HTTPМетод), HTTPЗапрос);
		Результат.КодСостояния =  HTTPОтвет.КодСостояния;
		Результат.ТелоОтвета =  HTTPОтвет.ПолучитьТелоКакСтроку(); 
		Результат.Заголовки = HTTPОтвет.Заголовки;
			
	Исключение
		Сообщить(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	Возврат Результат;
		
КонецФункции

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "УстановитьПараметрыСоединения" Тогда
		
		Объект.АдресПубликации  = Параметр.АдресПубликации;
		Объект.Логин  = Параметр.Логин;
		Объект.Пароль  = Параметр.Пароль;
		Объект.АутенфикацияОС = Параметр.АутенфикацияОС;
		
	ИначеЕсли ИмяСобытия = "ДобавитьОтвет" Тогда
		
		СтрокиТЧ = Объект.РезультатыЗапроса.НайтиСтроки(Новый Структура("КодОтвета", Параметр.КодСостояния));
		Если СтрокиТЧ.Количество() Тогда
			СтрокаТЧ = СтрокиТЧ[0];
		Иначе
			СтрокаТЧ = Объект.РезультатыЗапроса.Добавить();
		КонецЕсли;
		
		СтрокаТЧ.КодОтвета =  Параметр.КодСостояния;
		СтрокаТЧ.Значение   =  Параметр.ТелоОтвета;  
		СтрокаТЧ.Тип = ПолучитьТипSwaggerПоЗначению(ПолучитьЗначениеСтроки(СтрокаТЧ.Значение));
		СформироватьНотации(); 
		
		СтрокиДляУдаления = Объект.ПараметрыЗаголовкаРезультатаОтвета.НайтиСтроки(Новый Структура("КодОтвета",  Параметр.КодСостояния));
		Для Каждого СтрокаТЧ ИЗ СтрокиДляУдаления Цикл
			Объект.ПараметрыЗаголовкаРезультатаОтвета.Удалить(СтрокаТЧ);
		КонецЦикла;  
		
		Для Каждого Элемент ИЗ Параметр.ПараметрыЗаголовкаОтвета Цикл
			НоваяСтрока = Объект.ПараметрыЗаголовкаРезультатаОтвета.Добавить();
			НоваяСтрока.КодОтвета =  Параметр.КодСостояния;
			НоваяСтрока.Имя =  Элемент.Имя;
			НоваяСтрока.Тип =   ПолучитьТипSwaggerПоЗначению(ПолучитьЗначениеСтроки(Элемент.Значение)); 
			НоваяСтрока.Значение =  Элемент.Значение; 
		КонецЦикла;
		
		
	ИначеЕсли  ИмяСобытия = "ИзменитьЗначениеОJSON" Тогда
		
		Объект[Параметр.Таблица][Параметр.НомерСтроки-1][Параметр.Поле] = Параметр.Значение;
	    СформироватьНотации();

	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ГенерацияSwaggerJSON

&НаКлиенте
Асинх Процедура КаталогПроекта1СНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбора.Заголовок = "Выберите каталог";
	
	ВыбранныеФайлы = Ждать ДиалогВыбора.ВыбратьАсинх();
	Если ВыбранныеФайлы <> Неопределено И ВыбранныеФайлы.Количество() Тогда
		Объект.КаталогПроекта1с = ВыбранныеФайлы[0]; 	
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Асинх Процедура СгенерироватьSwaggerJSON(Команда)
	Если Не ЗначениеЗаполнено(Объект.КаталогПроекта1с) Тогда
		Возврат;
	КонецЕсли;
	
	СоответствиеПутей = Новый Соответствие;
	
	СоответствиеПутей = Ждать ПолучитьСоответствиеПутей();
	
	СгенерироватьSwaggerJSONНаСервере(СоответствиеПутей);
КонецПроцедуры 

&НаСервере
Процедура СгенерироватьSwaggerJSONНаСервере(СоответствиеПутей)	
	Если Объект.КаталогПроекта1с = "" Тогда
		Сообщить("Не выбран каталог конфигурации");
		Возврат;
	КонецЕсли;
	
	Объект.SwaggerJson = "";   	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	МассивНотацийКонфигурации = ОбработкаОбъект.ПолучитьМассивНотацийКонфигурации(СоответствиеПутей);
	РезультатФормирвоания = ОбработкаОбъект.СформироватьSwaggerПоНотациям(МассивНотацийКонфигурации);
	Если ЗначениеЗаполнено(РезультатФормирвоания.ТекстОшибки) Тогда
		Объект.SwaggerJson = РезультатФормирвоания.ТекстОшибки;  
		Объект.ОшибкаФормированияSwaggerJson  = Истина;
	Иначе
		Объект.SwaggerJson  = РезультатФормирвоания.SwaggerJson;
		Объект.ОшибкаФормированияSwaggerJson  = Ложь;
	Конецесли;
	
КонецПроцедуры        

&НаКлиенте
Асинх Функция ПолучитьСоответствиеПутей()
	Соответствие = Новый Соответствие;
	
	НайденныеФайлы = Ждать НайтиФайлыАсинх(Объект.КаталогПроекта1с + "\HTTPServices", "*", Истина);
	Для каждого Файл из НайденныеФайлы Цикл
		Если Файл.Имя = "Module.bsl" Тогда
			ДвоичныеДанные 	= Новый ДвоичныеДанные(Файл.ПолноеИмя);
			АдресВХ 		= ПоместитьВоВременноеХранилище(ДвоичныеДанные);
			Соответствие.Вставить(Файл.ПолноеИмя, АдресВХ);	  
		КонецЕсли;
	КонецЦикла;
	
	Возврат Соответствие;	
КонецФункции        

&НаСервере
Функция СформироватьSwaggerПоНотациямИзФормы(МассивНотаций, Сервер="http://host/hs#")

	Возврат РеквизитФормыВЗначение("Объект").СформироватьSwaggerПоНотациям(МассивНотаций, Сервер);
	
КонецФункции

&НаКлиенте
Процедура ПоказатьSwagger(Команда)
	
	Если Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаСборкаSwaggerJSON Тогда
		
		SwaggerJson = Объект.SwaggerJson; 	
		Если Не ЗначениеЗаполнено(SwaggerJson) Тогда
			Сообщить("Не Заполнено значение SwaggerJson");
			Возврат; 
		ИначеЕсли  Объект.ОшибкаФормированияSwaggerJson Тогда
			Сообщить("Swagger  JSON сформирован с ошибкой");
			Возврат; 
			
		КонецЕсли;
		
	Иначе         
		
		Если Объект.ОшибкаФормированияНотаций Тогда
			Сообщить("Проверьте корректность нотаций");
			Возврат;
		КонецЕсли;

		МассивНотаций = Новый Массив;
		МассивНотаций.Добавить(Объект.Нотации);
		РезультатФормирвоания = СформироватьSwaggerПоНотациямИзФормы(МассивНотаций);  
		Если ЗначениеЗаполнено(РезультатФормирвоания.ТекстОшибки) Тогда
			Объект.ОшибкаФормированияSwaggerJson  = Истина;
			Сообщить(СтрШаблон("Не удалаось получить Swagger  JSON из нотаций%1%2", Символы.ПС, РезультатФормирвоания.ТекстОшибки));
			Возврат;
		Иначе
			SwaggerJson  = РезультатФормирвоания.SwaggerJson;  
		Конецесли;
	КонецЕсли;
	
	SwaggerJson = СтрЗаменить(SwaggerJson, "http://host/hs#",СтрШаблон("https://%1/hs",Объект.АдресПубликации)); 
	ОткрытьФорму("ВнешняяОбработка.озГенерацияSwagger.Форма.SwaggerКлиент", Новый Структура("SwaggerJson", SwaggerJson)); 
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьТаблицыПоНотациям(Команда)

	ОписаниеОповещенияВопроса = Новый ОписаниеОповещения("ОбработатьВопросОчистки", ЭтаФорма);
	
	ПоказатьВопрос(ОписаниеОповещенияВопроса,
		"Форма будет очищена. Продолжить?",
		РежимДиалогаВопрос.ДаНет,,,
		"Заполнение по нотациям");	

КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВопросОчистки(Ответ, ДополнительныеПараметры) Экспорт 
    Если Ответ = КодВозвратаДиалога.Да Тогда	 
        ОписаниеОповещенияОбработки = Новый ОписаниеОповещения("ОбработатьСтрокуНотации", ЭтаФорма);
	
		ПоказатьВводСтроки(ОписаниеОповещенияОбработки,,"Введите строку нотаций",,Истина);
    КонецЕсли;
КонецПроцедуры   

&НаКлиенте
Процедура ОбработатьСтрокуНотации(Ответ, ДополнительныеПараметры) Экспорт 	
    Если НЕ ЗначениеЗаполнено(Ответ) Тогда	 
        Возврат;
    КонецЕсли;
	
    ЗаполнитьТаблицыПоНотациямиНаСервере(Ответ); 	
КонецПроцедуры	

&НаСервере
Процедура ЗаполнитьТаблицыПоНотациямиНаСервере(СтрокаНотации)

	Объект.Метод = "";
	Объект.Сервис = "";
	Объект.ПараметрыЗапроса.Очистить();
	Объект.РезультатыЗапроса.Очистить();
	Объект.Нотации = "";
	МассивСтрок = СтрРазделить(СтрокаНотации, Символы.ПС);      
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	СтруктураОписанияПолейНотации = ОбработкаОбъект.ПолучитьСтруктуруОписанияПолейНотаций(); 
	СодержаниеНотацийМетода = ОбработкаОбъект.ПолучитьСодержаниеНотаций(МассивСтрок, СтруктураОписанияПолейНотации);
	Сервис =  "";
	Путь = "";
	Для каждого Нотация из СодержаниеНотацийМетода Цикл
		Если Нотация.Ключ = ИменаНотаций["Router"] Тогда 
			Путь 	= Нотация.Значение[0].СтруктураПолейНотации.router;
			Метод 	= Нотация.Значение[0].СтруктураПолейНотации.method;
		ИначеЕсли Нотация.Ключ = ИменаНотаций["Param"] Тогда
			Для каждого ПараметрНотации из Нотация.Значение Цикл
				НовыйПараметр = Объект.ПараметрыЗапроса.Добавить(); 
				
				НовыйПараметр.Имя 					= ПараметрНотации.СтруктураПолейНотации.name; 
				НовыйПараметр.Комментарий 			= ПараметрНотации.СтруктураПолейНотации.description;
				НовыйПараметр.Обязательный 			= Булево(ПараметрНотации.СтруктураПолейНотации.required);
				НовыйПараметр.Значение 				= ПараметрНотации.ТекстЗначения;
				НовыйПараметр.Локация 				= ПараметрНотации.СтруктураПолейНотации.in;
				НовыйПараметр.Тип 					= ПараметрНотации.СтруктураПолейНотации.type;
			КонецЦикла;
		ИначеЕсли Нотация.Ключ = ИменаНотаций["Tags"] Тогда 
			Сервис = Нотация.Значение[0].СтруктураПолейНотации.tag;
		ИначеЕсли Нотация.Ключ = ИменаНотаций["Success"] ИЛИ Нотация.Ключ = ИменаНотаций["Failure"] Тогда  
			Для каждого ОтветНотации из Нотация.Значение Цикл 
				НовыйОтвет = Объект.РезультатыЗапроса.Добавить();
				
				НовыйОтвет.КодОтвета    	= ОтветНотации.СтруктураПолейНотации.code;
				НовыйОтвет.Значение     	= ОтветНотации.ТекстЗначения;
				НовыйОтвет.Тип          	= ОтветНотации.СтруктураПолейНотации.type;
				НовыйОтвет.Комментарий 		= ОтветНотации.СтруктураПолейНотации.description;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;  
	
	Если Метаданные.HTTPСервисы.Найти(Сервис) <> Неопределено Тогда
		Объект.Сервис = Метаданные.HTTPСервисы[Сервис].Имя;  
		СформироватьСписокМетодов();
		Для каждого ШаблонURL из Метаданные.HTTPСервисы[Сервис].ШаблоныURL Цикл
			Для каждого МетодШаблона из ШаблонURL.Методы Цикл
				Если НРег(Метод) = НРег(МетодШаблона.HTTPМетод) И  (НРег("/"+Метаданные.HTTPСервисы[Сервис].КорневойURL + ШаблонURL.Шаблон)=НРег(Путь)) Тогда
					Объект.Метод = ШаблонURL.Имя + "@" + МетодШаблона.Имя;
				КонецЕсли;    
			КонецЦикла;		
		КонецЦикла;
	КонецЕсли;

	СформироватьНотации();
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыЗаголовкаРезультатаОтветаПриИзменении(Элемент)

	СформироватьНотации();

КонецПроцедуры

&НаКлиенте
Процедура ПараметрыЗаголовкаРезультатаОтветаПослеУдаления(Элемент)
	
	СформироватьНотации();

КонецПроцедуры

#КонецОбласти  

#Область MonacoEditor  

Процедура ПриСозданииНаСервереMonacoEditor(Отказ, СтандартнаяОбработка)
	
	Обработка = РеквизитФормыВЗначение("Объект");
	Макет = Обработка.ПолучитьМакет("src"); 
	АдресМакета = ПоместитьВоВременноеХранилище(Макет, Новый УникальныйИдентификатор());
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеУдаленияВременныхФайлов(ДопПараметры) Экспорт
	
	ИмяФайла = КаталогИсходников + "monaco.zip";
	ДанныеМакета = ПолучитьИзВременногоХранилища(АдресМакета);
	ДанныеМакета.НачатьЗапись(Новый ОписаниеОповещения("ПослеЗаписиФайлаМакета", ЭтаФорма), ИмяФайла);
	
КонецПроцедуры 

&НаКлиенте
Процедура ПослеЗаписиФайлаМакета(ДопПараметры) Экспорт
	
	Попытка
		Файл = Новый ЧтениеZipФайла(КаталогИсходников + "monaco.zip");
		Файл.ИзвлечьВсе(КаталогИсходников);
		Файл.Закрыть();
		НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияАрхива", ЭтаФорма), КаталогИсходников, "monaco.zip"); 
		ТочкаВхода = КаталогИсходников + "index.html";		
		HTML = ТочкаВхода;
		ИсходникиЗагружены = Истина;
	Исключение
		ВывестиОшибку("Не удалось извлечь исходники" + Символы.ПС + ОписаниеОшибки(), Истина);
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеУдаленияАрхива(Результат) Экспорт
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	НачатьПодключениеРасширенияРаботыСФайлами(Новый ОписаниеОповещения("ПослеПодключенияРасширенияДляРаботыСФайлами", ЭтаФорма));
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПодключенияРасширенияДляРаботыСФайлами(Подключено, ДопПараметры) Экспорт
	Если Подключено Тогда
		ИзвлечьИсходники();	
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ИзвлечьИсходникиНаКлиенте()
	
	НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияВременныхФайлов", ЭтаФорма), КаталогИсходников, "*.*");
	
КонецПроцедуры

&НаКлиенте
Процедура ВывестиОшибку(Текст, ЗакрыватьКонсоль)
	
	ПоказатьПредупреждение(Новый ОписаниеОповещения("ПослеВыводаОшибки", ЭтаФорма, Новый Структура("ЗакрыватьКонсоль", ЗакрыватьКонсоль)), Текст);	
	
КонецПроцедуры  

&НаКлиенте
Процедура ПослеВыводаОшибки(ДопПараметры) Экспорт
	
	Если ДопПараметры.ЗакрыватьКонсоль Тогда
		ЗакрытьКонсоль();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьКонсоль()
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ИзвлечьИсходники()
	
	#Если ВебКлиент Тогда
		Сообщить("ВебКлиент не поддерживается");
	#Иначе
		НачатьПолучениеКаталогаВременныхФайлов(Новый ОписаниеОповещения("ПриПолученииКаталогаВременныхФайлов", ЭтаФорма));	
	#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуРедактированияJSON(Значение, Поле, Таблица, НомерСтроки)
	
	Если НЕ ИсходникиЗагружены Тогда
		Сообщить("Не удалось сформировать редактор");
		Возврат;
	КонецЕсли;
	
	ПараметрыРедактирования = Новый Структура("HTML", HTML);
	ПараметрыРедактирования.Вставить("Значение", Значение);
	ПараметрыРедактирования.Вставить("Поле", Поле);
	ПараметрыРедактирования.Вставить("Таблица", Таблица);
    ПараметрыРедактирования.Вставить("НомерСтроки", НомерСтроки);
	ОткрытьФорму("ВнешняяОбработка.озГенерацияSwagger.Форма.ФормаРедактированияJSON", ПараметрыРедактирования, ЭтотОбъект,,,,, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца); 

КонецПроцедуры 

&НаКлиенте
Процедура ПриПолученииКаталогаВременныхФайлов(ИмяКаталога, ДопПараметры) Экспорт
	
	КаталогИсходников = ИмяКаталога + "monaco3\";
	НачатьСозданиеКаталога(Новый ОписаниеОповещения("ПослеСозданияКаталога", ЭтаФорма), КаталогИсходников);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеСозданияКаталога(ИмяКаталога, ДопПараметры) Экспорт
	
	ФайлНаДиске = Новый Файл(КаталогИсходников);
	ФайлНаДиске.НачатьПроверкуСуществования(Новый ОписаниеОповещения("ПослеПроверкиСуществованияКаталога", ЭтаФорма));
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПроверкиСуществованияКаталога(Существует, ДопПараметры) Экспорт
	
	Если Существует Тогда		
		ФайлНаДиске = Новый Файл(КаталогИсходников + "index.html");
		ФайлНаДиске.НачатьПроверкуСуществования(Новый ОписаниеОповещения("ПослеПроверкиСуществованияИндексногоФайла", ЭтаФорма));
	Иначе		
		ВывестиОшибку("Не удалось создать каталог для исходников", Истина);		
	КонецЕсли;	
	
КонецПроцедуры 

&НаКлиенте
Процедура ПослеПроверкиСуществованияИндексногоФайла(Существует, ДопПараметры) Экспорт
	
	Если Существует Тогда		
		HTML = КаталогИсходников + "index.html";
		ИсходникиЗагружены = Истина;
	Иначе		
		ИзвлечьИсходникиНаКлиенте();
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьSwaggerJSON(Команда)
	Если Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаСборкаSwaggerJSON Тогда
		
		SwaggerJson = Объект.SwaggerJson;
		
	Иначе         
		
		Если Объект.ОшибкаФормированияНотаций Тогда
			Сообщить("Проверьте корректность нотаций");
			Возврат;
		КонецЕсли;

		МассивНотаций = Новый Массив;
		МассивНотаций.Добавить(Объект.Нотации);
		РезультатФормирвоания = СформироватьSwaggerПоНотациямИзФормы(МассивНотаций);  
		Если ЗначениеЗаполнено(РезультатФормирвоания.ТекстОшибки) Тогда
			Объект.ОшибкаФормированияSwaggerJson  = Истина;
			Сообщить(СтрШаблон("Не удалаось получить Swagger  JSON из нотаций%1%2", Символы.ПС, РезультатФормирвоания.ТекстОшибки));
			Возврат;
		Иначе
			SwaggerJson  = РезультатФормирвоания.SwaggerJson;  
		Конецесли;
	КонецЕсли; 
	
	SwaggerJson = СтрЗаменить(SwaggerJson, "http://host/hs#",СтрШаблон("https://%1/hs",Объект.АдресПубликации));
	
	ПараметрыРедактирования = Новый Структура("HTML", HTML);
	ПараметрыРедактирования.Вставить("Значение", SwaggerJson);
	ПараметрыРедактирования.Вставить("Поле", "Значение");
	ПараметрыРедактирования.Вставить("Таблица", "ПараметрыЗапроса");
    ПараметрыРедактирования.Вставить("НомерСтроки", 0);
	ПараметрыРедактирования.Вставить("ТолькоПросмотр", Истина);
	 
	ОткрытьФорму("ВнешняяОбработка.озГенерацияSwagger.Форма.ФормаРедактированияJSON", ПараметрыРедактирования);
КонецПроцедуры

#КонецОбласти 


