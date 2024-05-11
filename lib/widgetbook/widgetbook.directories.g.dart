// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:nike_sneaker_store/widgetbook/components/wgb_app_bar.dart'
    as _i2;
import 'package:nike_sneaker_store/widgetbook/components/wgb_avatar.dart'
    as _i3;
import 'package:nike_sneaker_store/widgetbook/components/wgb_button.dart'
    as _i4;
import 'package:nike_sneaker_store/widgetbook/components/wgb_card.dart' as _i7;
import 'package:nike_sneaker_store/widgetbook/components/wgb_otp.dart' as _i5;
import 'package:nike_sneaker_store/widgetbook/components/wgb_text_field.dart'
    as _i6;
import 'package:nike_sneaker_store/widgetbook/components/wgb_theme.dart' as _i8;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookFolder(
        name: 'app_bar',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'AppBarHome',
            useCase: _i1.WidgetbookUseCase(
              name: 'AppBar',
              builder: _i2.appBarHome,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'NSAppBar',
            useCase: _i1.WidgetbookUseCase(
              name: 'AppBar',
              builder: _i2.nsAppBar,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'avatar',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'NSAvatar',
            useCase: _i1.WidgetbookUseCase(
              name: 'Avatar',
              builder: _i3.nsAvatar,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'button',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'NSElevatedButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Button',
              builder: _i4.elevatedButton,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'NsIconButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Button',
              builder: _i4.iconButton,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'otp',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'NSOtpCode',
            useCase: _i1.WidgetbookUseCase(
              name: 'OTP',
              builder: _i5.nsOTPCode,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'text_form_field',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'NSTextFormField',
            useCase: _i1.WidgetbookUseCase(
              name: 'TextField',
              builder: _i6.nsTextFormField,
            ),
          )
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'features',
    children: [
      _i1.WidgetbookFolder(
        name: 'cart',
        children: [
          _i1.WidgetbookFolder(
            name: 'view',
            children: [
              _i1.WidgetbookFolder(
                name: 'widgets',
                children: [
                  _i1.WidgetbookLeafComponent(
                    name: 'CardCartProduct',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'Cards',
                      builder: _i7.cardCartProduct,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'home',
        children: [
          _i1.WidgetbookFolder(
            name: 'view',
            children: [
              _i1.WidgetbookFolder(
                name: 'widgets',
                children: [
                  _i1.WidgetbookLeafComponent(
                    name: 'CardCategory',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'Cards',
                      builder: _i7.cardCategory,
                    ),
                  ),
                  _i1.WidgetbookLeafComponent(
                    name: 'CardProduct',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'Cards',
                      builder: _i7.cardProduct,
                    ),
                  ),
                  _i1.WidgetbookLeafComponent(
                    name: 'CardSale',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'Cards',
                      builder: _i7.cardSale,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'notification',
        children: [
          _i1.WidgetbookFolder(
            name: 'view',
            children: [
              _i1.WidgetbookFolder(
                name: 'widgets',
                children: [
                  _i1.WidgetbookLeafComponent(
                    name: 'CardNotification',
                    useCase: _i1.WidgetbookUseCase(
                      name: 'Cards',
                      builder: _i7.cardNotification,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'themes',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'NSColorTheme',
        useCase: _i1.WidgetbookUseCase(
          name: 'Theme',
          builder: _i8.nsColorTheme,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'NSTextTheme',
        useCase: _i1.WidgetbookUseCase(
          name: 'Theme',
          builder: _i8.nsTextTheme,
        ),
      ),
    ],
  ),
];
