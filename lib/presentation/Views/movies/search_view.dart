
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/movies_repository_provider.dart';
import 'package:movies/presentation/widgets/movies/movie_search_item.dart';

class SearchView extends ConsumerStatefulWidget {

  final int? contentToShow;

  const SearchView({super.key, this.contentToShow = 1});

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends ConsumerState<SearchView> {

  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Duration _animationDuration = const Duration(milliseconds: 150);

  bool _isSearching = false;
  Color cancelIconColor = Colors.grey;
  double _opacity = 0.0;
  double _mainOpacity = 1.0;

  List<Movie> searchMovies = [];

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: _buildSearchAppBar(colors),
        actions: _buildActionButtons(),
        actionsPadding: const EdgeInsets.only(right: 12),
      ),
      body: Stack(
        children: <Widget>[
          
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _mainOpacity,
              duration: _animationDuration,
              child: const MainContainer()
            ),
          ),
      
          if( _isSearching == true )
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: _animationDuration,
                child: Container(
                  child: _inputController.text.isEmpty
                    ? _buildSuggestions()
                    : _buildResults()
                ),
              ),
            ),
        ],
      ),
    );
  }

  void toggleSearch(bool start) {
    if( _isSearching && start ) return;
    if( !_isSearching && !start ) return;

    if( !_isSearching ) { // start search
      _isSearching = true;
      _opacity = 0.0;
      _mainOpacity = 1.0;
    } else { // end search
      _opacity = 0.0;
      _inputController.clear();
      _focusNode.unfocus();
    }
    setState(() {});

    Future.delayed(_animationDuration, (){
      if( start ) { // start search
        _opacity = 1.0;
        _mainOpacity = 0.0;
      } else { // end search
        _isSearching = false;
        _mainOpacity = 1.0;
      }
      setState(() {});
    });
  }

  List<Widget>? _buildActionButtons() {
    return [
      if( _isSearching )
        GestureDetector(
          onTap: () => toggleSearch(false),
          child: const Text('Cancelar', style: TextStyle(fontSize: 18))
        )
    ];
  }

  Widget _buildSearchAppBar( ColorScheme colors ) {
    return SizedBox(
      height: 30,
      child: TextField(
        controller: _inputController,
        focusNode: _focusNode,
        onTap: () => toggleSearch(true),
        onChanged: (value) async{
          print('buscando');
          searchMovies = await ref.read( moviesRepositoryProvider ).executeSearchMovies(value);
          setState(() {});
        },
        cursorHeight: 16,
        minLines: 1,
        maxLines: 1,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 16 ),
        decoration:  InputDecoration(
          prefixIcon: const Icon(Icons.search_outlined, size: 18),
          prefixIconConstraints: const BoxConstraints(minWidth: 30),
          suffixIcon: ( _isSearching && _inputController.text.isNotEmpty ) 
            ? GestureDetector(
                onTapDown: (details) => setState(() => cancelIconColor = Colors.black),
                onTapUp: (details) => setState(() => cancelIconColor = Colors.grey),
                onTapCancel: () => setState(() => cancelIconColor = Colors.grey),
                onTap: () => setState(() => _inputController.clear() ),
                child: Icon(Icons.cancel_rounded, size: 18, color: cancelIconColor,)
              ) 
            : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: colors.secondaryContainer,
          hintText: 'Buscar',
          hintStyle: const TextStyle(fontSize: 16),
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }

  Widget _buildResults() {
    return ListView.builder(
      itemCount: searchMovies.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: MovieSearchItem(searchMovie: searchMovies[index]),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Material(
        color: Colors.transparent,
        child: ListTile(
          tileColor: Colors.transparent,
          leading: const Icon(Icons.search),
          trailing: GestureDetector(
            onTap: () {
              print('deleted');
            },
            child: const Icon(Icons.close_outlined, size: 18)
          ),
          title: Text("Suggestion #$index"),
          onTap: () {
            
          },
        ),
      ),
    );
  }
  
}


class MainContainer extends StatelessWidget {
  const MainContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}