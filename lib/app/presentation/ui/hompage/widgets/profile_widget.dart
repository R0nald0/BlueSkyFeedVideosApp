import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String userName;
  final String profileImage;


  const ProfileWidget({super.key ,required this.userName,required this.profileImage});

  @override
  Widget build(BuildContext context) {
   final mediaQuery = MediaQuery.of(context).size;
    return Container(
               height: mediaQuery.height * 0.13,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(200),
              ),
              child: ListTile(
                 leading: CircleAvatar(
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  
                title : Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                             color: Colors.white,
                            fontSize: 21
                            ),
                        ),
                    ),
                      Expanded(
                        flex: 2,
                        child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        userName,
                        style: const TextStyle(
                           color: Colors.white,
                          fontSize: 14
                          ),
                                            ),
                      ),
                  ],
                ),
              ),
            );
  }
}