import 'package:dw_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/Post.dart';
import '../resources/news_api_provider.dart';

class PostsBloc {
  final _repository = Repository();
  final _posts = PublishSubject<List<Post>>();

  Observable<List<Post>> get posts => _posts.stream;

  fetchPosts(catagory) async {
    final posts = await _repository.fetchPosts(catagory);
    _posts.sink.add(posts);
  }

  dispose() {
    _posts.close();
  }
}
