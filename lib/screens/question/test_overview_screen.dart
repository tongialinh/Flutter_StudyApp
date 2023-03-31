import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_papers/questions_controller.dart';
import 'package:study_app/screens/home/question_card.dart';
import 'package:get/get.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_app_bar.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/countdown_timer.dart';
import 'package:study_app/widgets/questions/question_number_card.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({Key? key}) : super(key: key);
  static const String routeName ="/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,

      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CountdownTimer(
                            color: UIParamenters.isDarkMode()?
                            Theme.of(context).textTheme.bodyText1!.color
                                :Theme.of(context).primaryColor,
                            time: '',
                          ),
                          Obx(
                                  ()=>Text(
                                '${controller.time} Remaining',
                                style: countDownTimerTS(),
                              )
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                     Expanded(
                       child:  GridView.builder(
                           itemCount: controller.allQuestions.length,
                           shrinkWrap: true,
                           physics: BouncingScrollPhysics(),
                           gridDelegate:
                           SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: Get.width ~/75,
                               childAspectRatio: 1,
                               crossAxisSpacing: 8,
                               mainAxisSpacing: 8
                           ),
                           itemBuilder: (_, index){
                             AnswerStatus? _answerStatus;
                             if(controller.allQuestions[index].selectedAnswer!=null){
                               _answerStatus = AnswerStatus.answered;
                             }
                            return QuestionNumberCard(
                              index:  index+1,
                              status: _answerStatus,
                              onTap: ()=>controller.jumpToQuestion(index)
                            );
                           }),
                     )
                    ],
                  )
                ),
            ),
            ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
             child:   Padding(
               padding: UIParamenters.mobileScreenPadding,
               child: MainButton(
                 onTap: (){
                   controller.complete();
                 },
                 title: 'Complete',
               ),
             )

              ),

          ],
        )
      ),
    );
  }
}
