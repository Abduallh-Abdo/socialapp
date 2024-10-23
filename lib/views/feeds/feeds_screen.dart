import 'package:flutter/material.dart';
import 'package:socialapp/components/components.dart';
import 'package:socialapp/helper/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: [
              // Main card at the top
              Card(
                elevation: 10,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    const Image(
                      image: NetworkImage(
                        'https://c4.wallpaperflare.com/wallpaper/131/492/954/kimi-no-na-wa-makoto-shinkai-starry-night-comet-wallpaper-preview.jpg',
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Communicate with friends',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // List of cards Posts
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => customCard(context: context),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Post Card
  Widget customCard({required BuildContext context}) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile section
          ListTile(
            leading: profileAvatar(
              radius: 40,
              url:
                  'https://c4.wallpaperflare.com/wallpaper/116/412/889/naruto-anime-uchiha-itachi-hd-wallpaper-preview.jpg',
            ),
            title: Text(
              'Dansho',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              'December 22, 2002',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            trailing: const Icon(Icons.keyboard_control_outlined),
          ),
          const Divider(
            height: 15,
            color: Colors.grey,
            indent: 10,
            endIndent: 10,
          ),
          //post text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  // fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          // Post tags
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 4.0, // Reduced horizontal spacing between tags
              runSpacing: 4.0, // Vertical spacing between rows if wrapped
              children: [
                tagButton('#Anime', context),
                tagButton('#Manga', context),
                tagButton('#Art', context),
                tagButton('#Comics', context),
              ],
            ),
          ),
          // Post image
          const Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              image: NetworkImage(
                  'https://c4.wallpaperflare.com/wallpaper/803/347/759/anime-natural-light-landscape-forest-studio-ghibli-hd-wallpaper-preview.jpg'),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // Like and comment counts
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text('555'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 5),
                        Text('5'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Write a comment section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                profileAvatar(
                    url:
                        'https://c4.wallpaperflare.com/wallpaper/116/412/889/naruto-anime-uchiha-itachi-hd-wallpaper-preview.jpg',
                    radius: 20),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Write a comment...',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(IconBroken.Heart, color: Colors.red),
                      SizedBox(width: 5),
                      Text('Like'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(IconBroken.Chat, color: Colors.amber),
                      SizedBox(width: 5),
                      Text('Comment'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget tagButton(String text, BuildContext context) {
    return SizedBox(
      height: 25,
      child: MaterialButton(
        minWidth: 1,
        padding: EdgeInsets.zero, // Removes internal padding
        materialTapTargetSize: MaterialTapTargetSize
            .shrinkWrap, // Shrinks the button to fit the content
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  // Reusable profile avatar
}
