// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum Button {
    /// Добавить в корзину
    internal static let addCart = L10n.tr("Localizable", "Button.addCart")
    /// Оплатить
    internal static let pay = L10n.tr("Localizable", "Button.pay")
  }

  internal enum Cart {
    /// Ваш заказ принят!
    internal static let number = L10n.tr("Localizable", "Cart.number")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "Cart.ok")
    /// № 100730
    internal static let order = L10n.tr("Localizable", "Cart.order")
  }

  internal enum Cell {
    /// CartCell
    internal static let cart = L10n.tr("Localizable", "Cell.cart")
    /// CategoryCell
    internal static let category = L10n.tr("Localizable", "Cell.category")
    /// CategoryHeaderView
    internal static let categoryHeader = L10n.tr("Localizable", "Cell.categoryHeader")
  }

  internal enum Cuisine {
    /// Азиатская кухня
    internal static let asian = L10n.tr("Localizable", "Cuisine.asian")
    /// Пекарни \nи кондитерские 
    internal static let bakery = L10n.tr("Localizable", "Cuisine.bakery")
    /// Фастфуд
    internal static let fastfood = L10n.tr("Localizable", "Cuisine.fastfood")
    /// Супы
    internal static let soups = L10n.tr("Localizable", "Cuisine.soups")
  }

  internal enum FatalError {
    /// Unable to dequeue Cell
    internal static let cell = L10n.tr("Localizable", "FatalError.cell")
    /// init(coder:) has not been implemented
    internal static let `required` = L10n.tr("Localizable", "FatalError.required")
  }

  internal enum Location {
    /// Санкт-Петербург
    internal static let city = L10n.tr("Localizable", "Location.city")
    ///  ₽
    internal static let currency = L10n.tr("Localizable", "Location.currency")
    /// dd MMMM, yyyy
    internal static let date = L10n.tr("Localizable", "Location.date")
    ///  · 
    internal static let separator = L10n.tr("Localizable", "Location.separator")
    /// г
    internal static let unit = L10n.tr("Localizable", "Location.unit")
    ///  
    internal static let whitespace = L10n.tr("Localizable", "Location.whitespace")
  }

  internal enum NotificationCenter {
    /// cartUpdated
    internal static let cartUpdated = L10n.tr("Localizable", "NotificationCenter.cartUpdated")
  }

  internal enum SystemImage {
    /// person.circle
    internal static let account = L10n.tr("Localizable", "SystemImage.account")
    /// basket
    internal static let cart = L10n.tr("Localizable", "SystemImage.cart")
    /// heart
    internal static let heart = L10n.tr("Localizable", "SystemImage.heart")
    /// heart.fill
    internal static let heartFill = L10n.tr("Localizable", "SystemImage.heartFill")
    /// location.fill
    internal static let location = L10n.tr("Localizable", "SystemImage.location")
    /// pentagon
    internal static let main = L10n.tr("Localizable", "SystemImage.main")
    /// minus
    internal static let minus = L10n.tr("Localizable", "SystemImage.minus")
    /// plus
    internal static let plus = L10n.tr("Localizable", "SystemImage.plus")
    /// magnifyingglass
    internal static let search = L10n.tr("Localizable", "SystemImage.search")
    /// xmark
    internal static let xmark = L10n.tr("Localizable", "SystemImage.xmark")
  }

  internal enum TabBar {
    /// Аккаунт
    internal static let account = L10n.tr("Localizable", "TabBar.account")
    /// Корзина
    internal static let cart = L10n.tr("Localizable", "TabBar.cart")
    /// Главная
    internal static let main = L10n.tr("Localizable", "TabBar.main")
    /// Поиск
    internal static let search = L10n.tr("Localizable", "TabBar.search")
  }

  internal enum Tag {
    /// Все меню
    internal static let all = L10n.tr("Localizable", "Tag.all")
    /// С рыбой
    internal static let fish = L10n.tr("Localizable", "Tag.fish")
    /// С рисом
    internal static let rice = L10n.tr("Localizable", "Tag.rice")
    /// Роллы
    internal static let roll = L10n.tr("Localizable", "Tag.roll")
    /// Салаты
    internal static let salad = L10n.tr("Localizable", "Tag.salad")
  }

  internal enum Url {
    /// https://github.com/logunkov/Tanuki/raw/main/JSON/dishes.json
    internal static let dishes = L10n.tr("Localizable", "URL.dishes")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all