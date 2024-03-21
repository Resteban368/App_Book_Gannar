import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/config/theme/text_style.dart';
import 'package:gannar/presentation/modules/home/delegates/search_book_delegate.dart';

import '../../../blocs/theme/theme_bloc.dart';

class ContainerSearch extends StatelessWidget {
  const ContainerSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: SearchBook());
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.watch<ThemeBloc>().state.theme == AppTheme.light
              ? Colors.grey[200]
              : Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.deepPurple[300]),
            const SizedBox(width: 10),
            Text("Buscar libro", style: TextStyles.mediumBlack(context)),
            const Spacer(),
            Icon(Icons.book, color: Colors.deepPurple[300]),
          ],
        ),
      ),
    );
  }
}
