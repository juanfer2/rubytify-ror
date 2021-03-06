module Api
  module V1
      class AlbumsController < ApplicationController
        def songs_by_album
          album = Album.find_by(id: params[:id])
          if album.present?
            @songs = album.songs
            render json: @songs, root: 'data', adapter: :json, each_serializer: SongSerializer
          else
            render :json => {msg: "album with id #{params[:id]}, not found "}.to_json, :status => 404 
          end
        end
      end
  end
end