require 'rails_helper'

describe 'routing to images', type: :routing do
  it 'routes /images to images#index' do
    expect(get: '/images').to route_to(
      controller: 'images',
      action: 'index'
    )
  end

  it 'routes /images/1 to images#show' do
    expect(get: '/images/1').to route_to(
      controller: 'images',
      action: 'show',
      id: '1'
    )
  end

  it 'routes /images/small/1 to images#small' do
    expect(get: 'images/small/1').to route_to(
      controller: 'images',
      action: 'small',
      id: '1'
    )
  end

  it 'routes /images/medium/1 to images#small' do
    expect(get: 'images/medium/1').to route_to(
      controller: 'images',
      action: 'medium',
      id: '1'
    )
  end

  it 'routes /images/large/1 to images#small' do
    expect(get: 'images/large/1').to route_to(
      controller: 'images',
      action: 'large',
      id: '1'
    )
  end

  it 'routes /images/new to images#new' do
    expect(get: '/images/new').to route_to(
      controller: 'images',
      action: "new"
    )
  end

  it 'routes /images to images#create' do
    expect(post: '/images').to route_to(
      controller: 'images',
      action: 'create'
    )
  end

  it 'routes /images/1/edit to books#edit' do
    expect(get: '/images/1/edit').to route_to(
      controller: 'images',
      action: 'edit',
      id: '1'
    )
  end

  it 'routes /images/1 to images#update' do
    expect(put: '/images/1').to route_to(
      controller: 'images',
      action: 'update',
      id: '1'
    )
  end

  it 'routes /images/1 to books#destroy' do
    expect(delete: '/images/1').to route_to(
      controller: 'images',
      action: 'destroy',
      id: '1'
    )
  end
end
