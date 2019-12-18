class MembersController < ApplicationController
    before_action :find_group
    before_action :find_member, only: [:find_group, :destroy]

    def create
        if already_joined?
            flash[:notice] = "You are already in that group"
        else
        Member.create(user: current_user, group: Group.find_by(id: params[:id]))
        end
        redirect_back(fallback_location: '/groups')
    end
  
    def destroy
        if current_user == @member.user
            if !(already_joined?)
                flash[:notice] = "You aren't a part of that group yet"
            else
                @member.destroy
            end
        end
        redirect_back(fallback_location: '/groups')
    end

    private
  
    def find_member
    
        @member = Member.where(user: current_user, group: Group.find(params[:id])).first
    end

    def find_group
        @group = Group.find_by(id: params[:id])
        if !@group
          flash[:error] = "You shouldn't edit HTML"
          redirect_back(fallback_location: '/groups')
        end
      end
  
      def already_joined?
        Member.where(user: current_user, group: Group.find(params[:id])).exists?
      end
end
