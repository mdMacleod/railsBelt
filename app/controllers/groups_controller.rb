class GroupsController < ApplicationController


    def new
        @group = Group.new
        @groups = Group.all
    end

    def show
        @group = Group.find_by(id: params[:id])
        @members = @group.members.all
    end

    def create
        @group = Group.new(hidden_params)
        if @group.valid?
            @group = Group.create(hidden_params)
            Member.create(user: current_user, group: @group)
            redirect_back(fallback_location: '/groups')
        else
            flash[:error] = @group.errors.full_messages
            render :errors
        end
    end

    def delete
        @group = Group.find(params[:id])
        if current_user.id == @group.user.id
            @group.destroy
            redirect_back(fallback_location: '/groups')
        else
            flash[:message] = "You shouldn't be playing with HTML like that."
            redirect_back(fallback_location: '/groups')
        end
    end

    private

    def hidden_params
        params.require(:group).permit(:name, :description).merge(user: current_user)
    end
end
