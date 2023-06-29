import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/Social_App/posr_model.dart';
import 'package:untitled/models/Social_App/social_user_model.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
  var commentController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
         if (State is SocialDownloudImgeSucessState)
            ShowToast(text: 'save imge Sucess ', state: ToastStates.ERROR);
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        
        return ConditionalBuilder(
          condition: (cubit.usermodel != null &&
              cubit.posts.length > 0 &&
              cubit.likes.length > 0), //&&cubit.likes.length > 0,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Card(
                  elevation: 10.0,
                  margin: EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                          image: AssetImage('android/assets/images/work.jpg'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('the real frind',
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                      ])),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => buildPostItem(
                    cubit.posts[index], context, cubit.usermodel, index)),
                itemCount: cubit.posts.length,
                separatorBuilder: ( context, index) =>const SizedBox(
                  height: 8,
                ),
              ),
              const SizedBox(
                height: 8,
              )
            ]),
          ),
          fallback: (context) =>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(
          PostModel model, context, SocialUserModel? usermodel, index) =>
      Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        '${model.image}') //SocialCubit.get(context).usermodel!.image.toString() ),
                    ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SingleChildScrollView(

                          child: Text(
                            '${model.name}',
                            style: TextStyle(height: 1.4, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.blue,
                          size: 16,
                        )
                      ],
                    ),
                    Text('${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(height: 1.4, fontSize: 8)),
                  ],
                )),
                const SizedBox(
                  width: 15.0,
                ),
                //  List<String> list =['vvv',]
                if (model.postImage == '')
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz, size: 25)),
                if (model.postImage != '')
                  Container(
                    height: 40,
                    child: SizedBox(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Color.fromARGB(255, 101, 155, 243),
                        style: const TextStyle(color: Colors.black45),
                        underline: const SizedBox(),
                        onTap: () {},
                        items: [
                          DropdownMenuItem(
                            onTap: (() {
                              SocialCubit.get(context).downloudImge(model.postImage).then((value) {
                                if( value==true){
                                  ShowToast(text: 'save imge Sucess ', state: ToastStates.SUCCESS);
                                }else{
                                   ShowToast(text: 'save imge  fildee ', state: ToastStates.ERROR);

                                }
                               
                              });
                            
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Text(
                                      'save image',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                const Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.download,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        hint: const Text(''),
                        onChanged: ((value) {}),
                        icon: const Icon(Icons.more_horiz, size: 25),
                      ),
                    ),
                  )
              ],
            ), // Icon(Icons.more_horiz, size: 17),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(height: 1, color: Colors.black87, fontSize: 15.0),
            ),
            // if(model.postImage=='')
            /* Padding(
              padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5.0),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#eid',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: defaultColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            '${model.postImage}'), //AssetImage('android/assets/images/work.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      //  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 26, 56, 104),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(
                                Icons.favorite_outline_sharp,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            '${SocialCubit.get(context).likes[index]} Likes',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Expanded(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 26, 56, 104),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.chat_rounded,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(right: 1),
                              child: Text(
                                '0 commint',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (() {}),
                    child: Container(
                      height: 31.5,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 19.0,
                            backgroundImage: NetworkImage(
                                '${usermodel!.image}' //SocialCubit.get(context).usermodel!.image.toString()
                                ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          //if( commentController.text=='')
                          Expanded(
                            child: TextFormField(
                                //controller: commentController ,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(height: 1.4),
                                decoration: InputDecoration(
                                  hintText: 'Write a comment',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    print('comment must not be empty');
                                  }
                                }),
                          ),
                          /* Text('Write a comment',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(height: 1.4)),*/
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Container(
                      height: 31.5,
                      //  width: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_outline_sharp,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'like  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      );
}
