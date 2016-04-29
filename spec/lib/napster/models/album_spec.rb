require 'spec_helper'
fixture = FixtureLoader.init('main.json')
config_hash = ConfigLoader.init
config_variables = config_hash['config_variables']
options = {
  api_key: config_variables['API_KEY'],
  api_secret: config_variables['API_SECRET']
}
client = Napster::Client.new(options)

describe Napster::Models::Album do
  it 'has a class' do
    expect(Napster::Models::Album).not_to be nil
  end

  describe '.new' do
    it 'should instantiate without data' do
      album = Napster::Models::Album.new({})

      expect(album.class).to eql(Napster::Models::Album)
    end

    it 'should instantiate with a client' do
      album = Napster::Models::Album.new(client: client)

      expect(album.class).to eql(Napster::Models::Album)
    end
  end

  it '#new_releases' do
    albums = client.albums.new_releases
    expect(albums.class).to eql(Array)
    expect(albums.first.class).to eql(Napster::Models::Album)
  end

  it '#top' do
    albums = client.albums.top
    expect(albums.class).to eql(Array)
    expect(albums.first.class).to eql(Napster::Models::Album)
  end

  describe '#find' do
    it 'by id' do
      album_id = fixture['album']['id']
      album = client.albums.find(album_id)
      expect(album.class).to eql(Napster::Models::Album)
    end

    it 'by name' do
      album_name = fixture['album']['name']
      album = client.albums.find(album_name)
      expect(album.class).to eql(Napster::Models::Album)
    end
  end

  it 'album.tracks' do
    album_id = fixture['album']['id']
    tracks = client.albums.find(album_id).tracks
    expect(tracks.class).to eql(Array)
    expect(tracks.first.class).to eql(Napster::Models::Track)
  end

  it 'album.similar' do
    album_id = fixture['album']['id']
    albums = client.albums.find(album_id).similar
    expect(albums.class).to eql(Array)
    expect(albums.first.class).to eql(Napster::Models::Album)
  end

  it 'album.favorited_members' do
    album_id = fixture['album']['id']
    members = client.albums.find(album_id).favorited_members
    expect(members.class).to eql(Array)
    expect(members.first.class).to eql(Napster::Models::Member)
  end

  it 'album.top_listeners' do
    album_id = fixture['album']['id']
    members = client.albums.find(album_id).top_listeners(range: 'week')
    expect(members.class).to eql(Array)
    expect(members.first.class).to eql(Napster::Models::Member)
  end
end
