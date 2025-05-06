// @Tags		MDM
// @Summary		MDM (Products GET)
// @Description		MDM (Products GET)
// @Router	/mdm/* [GET]
// @Produce json
// @Accept	json
// @Param		name		query		string		false		"поиск по наименованию"
// <value>
// tele
// </value>
// @Success		200		{array}	array		"ок"
// <value>
// [{"id":1,"name":"Смартфон XYZ","price":599.99},{"id":2,"name":"Ноутбук ABC","price":1299.99}]
// </value>
Функция productsGET(Запрос)  	

	Возврат ОбработчикHTTP.ПолучитьОтвет(Запрос, "GET mdm/products" , "Products.productsGET");

КонецФункции

// @Tags		MDM
// @Summary		MDM (Products POST)
// @Description		MDM (Products POST)
// @Router	/mdm/* [POST]
// @Produce json
// @Accept	json
// @Param		requestBody		body		object		true		"Записываемый товар"
// <value>
// {
//     "id": 1,
//     "name": "Смартфон XYZ",
//     "price": 599.99
// }
// </value>
// @Success		200		{string}	string		"Полученный идентификатор норменклатуры"
// <value>
// b267ff8e-55b4-4db0-aded-65cc2efd57fa
// </value>
Функция productsPOST(Запрос)
	
	Возврат ОбработчикHTTP.ПолучитьОтвет(Запрос, "POST mdm/products", "Products.productsPOST");

КонецФункции
