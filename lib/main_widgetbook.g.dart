// *********************************************************************************
// PARABEAC-GENERATED CODE. DO NOT MODIFY.
// 
// FOR MORE INFORMATION ON HOW TO USE PARABEAC, PLEASE VISIT docs.parabeac.com
// *********************************************************************************
    

    import 'package:widgetbook/widgetbook.dart';
    import 'package:flutter/material.dart';
    import 'package:nosso/widgets/telas/splash_screen.g.dart';
import 'package:nosso/widgets/telas/esqueceu_a_senha?.g.dart';


    void main() {
      runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
      const MyApp({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context){
        return Widgetbook(
          themes: [
            WidgetbookTheme(name: 'Light', data: ThemeData.light()),
          ],
          devices: const [
            Apple.iPhone11ProMax,
            Samsung.s10,
          ],
          categories: [
                  WidgetbookCategory(
        name: 'Parabeac-Generated',
        folders: [
      WidgetbookFolder(
        name: 'telas',
        widgets: [
      WidgetbookWidget(
        name: 'SplashScreen',
        useCases: [
      WidgetbookUseCase(
        name: 'SplashScreen',
        builder: (context) => Center(child:       SizedBox(
        height: 640.0,width: 360.0,
        child: LayoutBuilder( 
  builder: (context, constraints) {
    return SplashScreen(
constraints,
)
;
}
),
      ),
    ),
      ),
    
],

      )
    ,
      WidgetbookWidget(
        name: 'esqueceu a senha?',
        useCases: [
      WidgetbookUseCase(
        name: 'EsqueceuASenha?',
        builder: (context) => Center(child:       SizedBox(
        height: 16.0,width: 138.0,
        child: LayoutBuilder( 
  builder: (context, constraints) {
    return EsqueceuASenha(
constraints,
)
;
}
),
      ),
    ),
      ),
    
],

      )
    
],

      ),
    
],

        
      )
    ,
          ],
          appInfo: AppInfo(name: 'MyApp'),
        );
      }
    }
    