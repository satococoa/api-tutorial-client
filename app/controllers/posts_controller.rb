class PostsController < UITableViewController
  def viewDidLoad
    @posts = []
    BW::HTTP.get('http://localhost:3000/api/v1/posts.json') do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_s)
        @posts += json
        tableView.reloadData
      else
        App.alert(response.error_message)
      end
    end
  end

  def tableView(table_view, numberOfRowsInSection: section)
    @posts.count
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    cell = table_view.dequeueReusableCellWithIdentifier('post_cell', forIndexPath: index_path)
    post = @posts[index_path.row]
    cell.textLabel.text = post['title']
    cell.detailTextLabel.text = post['body']
    cell
  end
end