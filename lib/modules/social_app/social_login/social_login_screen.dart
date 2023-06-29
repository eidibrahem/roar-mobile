import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/social_app/social_login/cubit/cubit.dart';
import 'package:untitled/modules/social_app/social_login/cubit/states.dart';
import 'package:untitled/modules/social_app/social_login/social_regester/social_regester_screen.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../../../shared/componants/componant.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
      listener: (BuildContext context, Object? state) 
      {
       if(state is SocialLoginErorrState)
       {
        ShowToast(state:  ToastStates.ERROR , text: state.error);
       } 
       if(state is SocialLoginSucccessState)
       {
        CacheHelper.saveData(
                      key: 'uId',
                     value: state.uId)
                  .then((value) => navigatAndFinsh(
                      context, SocialLayout()));
            /*   CacheHelper.saveData(
                  key: 'name', v);

              CacheHelper.saveData(
                  key: 'phone', value: state.loginMoDel?.data!.phone);
 */
       }
      },
      builder: (BuildContext context, state) {
        return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style:
                            Theme.of(context).textTheme.headline4?.copyWith(
                                  color: Colors.black,
                                ),
                      ),
                      Text(
                        'Login now to communicate with frinds',
                        style:
                            Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormFieldX(
                        Controller: emailController,
                        type: TextInputType.emailAddress,
                        style:  Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 18),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address ';
                          }
                        },
                        color: Colors.black,
                        label: 'Email address',
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormFieldX(
                        onsubmit: (value) {
                          if (formkey.currentState!.validate()) {
                            /*   SocialLoginCubit.git(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text); */
                          }
                        },
                        style:  Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 18),
                        Controller: passwordController,
                        ispass: SocialLoginCubit.git(context).ispass,
                        type: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is to short ';
                          }
                        },
                        color: Colors.black,
                        label: 'password',
                        prefix: Icons.lock_outline,
                        suffix: SocialLoginCubit.git(context).suffix,
                        suffixpressed: () {
                          SocialLoginCubit.git(context)
                              .changePasssVisibility();
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLogLodingState,
                        builder: (context) => defaultButton(
                            onPress: () {
                              if (formkey.currentState!.validate()) {
                                 SocialLoginCubit.git(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    CacheHelper.saveData(
                                        key: 'email',
                                        value: emailController.text);
                              }
                            },
                            text: 'login',
                            isUperCse: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?  '),
                            defaultTextButton(
                                onPress: () {
                                 navigatTo(context, SocialRegesterScreen());
                                },
                                text: 'regester'),
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
