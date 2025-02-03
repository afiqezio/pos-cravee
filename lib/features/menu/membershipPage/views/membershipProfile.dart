import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:possystem/core/utils/appHelper.dart';

class MembershipProfile extends StatelessWidget {
  const MembershipProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/membership/membershipBg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        'assets/svg/pretzley.svg',
                        height: 36,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/dummy/gold_tier.png',
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "999 pts",
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "MUHAMMAD FAHMI MIKAIL",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Card(
                            color: const Color(0xFFEAAA08),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4),
                              child: Text(
                                "Gold",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Text(
                            "Collect more points to unlock the new tier",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          // Progress Bar
                          LinearProgressIndicator(
                            value: 0.6,
                            minHeight: 8,
                            backgroundColor: Color(0xFFFEF7C3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFFAC515)),
                          ),
                          // Progress Description
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Progress
                              Text(
                                "999pts / 1500pts",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              // Percent
                              Text(
                                "60%",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
