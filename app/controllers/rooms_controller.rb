class RoomsController < ApplicationController
  def show
    @messages = Message.all

    @connection_num = ActionCable
                      .server.open_connections_statistics
                      .map { |con| con[:subscriptions]
                      .map { |sub| JSON.parse(sub)["url"] } } # ここのurlを変えれば特定の接続数を取得できるはず
                      .flatten
                      .select { |url| url == 'http://localhost:3000' } # ここで特定のチャネル一致
                      .size
  end
end
